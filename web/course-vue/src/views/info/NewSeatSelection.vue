<template>
  <div class="seat-selection-container">
    <!-- 左侧座位选择区域 -->
    <div class="seat-map">
      <div v-for="(row, rowIndex) in seatRows" :key="rowIndex" class="seat-row">
        <div class="row-header">
          <span class="row-number">{{ String(rowIndex + 1).padStart(2, "0") }}排</span>
        </div>
        <div class="seat-container">
          <div v-for="(seat, columnIndex) in row" :key="columnIndex" class="seat-card">
            <span v-if="columnIndex === 3" class="aisle-text"> |---过道---| </span>
            <button
              @click="selectSeat(seat.row, seat.column)"
              :class="{
                selected: isSelected(seat.row, seat.column),
                occupied: seat.disabled,
              }"
              :disabled="seat.disabled"
              class="seat-button"
            >
              <div class="seat-info">
                <span class="seat-number">{{ seat.row }}排{{ seat.column }}座</span>
                <span class="status">{{ seat.disabled ? "已售出" : "可选" }}</span>
              </div>
            </button>
          </div>
        </div>
        <div class="row-header">
          <span class="row-number">{{ String(rowIndex + 1).padStart(2, "0") }}排</span>
        </div>
      </div>
    </div>
    <!-- 右侧座位信息和购买区域 -->
    <div class="seat-details">
      <h3>
        <el-icon><InfoFilled /></el-icon>选中的座位信息：
      </h3>
      <form>
        <div v-if="selectedSeatRow !== null && selectedSeatColumn !== null">
          <label for="selectedSeatRow">行号：</label>
          <input type="text" id="selectedSeatRow" v-model="selectedSeatRow" readonly />
        </div>
        <div v-if="selectedSeatRow !== null && selectedSeatColumn !== null">
          <label for="selectedSeatColumn">列号：</label>
          <input
            type="text"
            id="selectedSeatColumn"
            v-model="selectedSeatColumn"
            readonly
          />
        </div>
        <div v-if="selectedSeatRow !== null && selectedSeatColumn !== null">
          <label for="ticketPrice">票价：</label>
          <!--<div v-show="false">{{ getPrice(seatType) }}</div>-->
          <span id="ticketPrice">{{ priceInfo.price }}￥</span>
        </div>
        <el-button
          type="primary"
          :disabled="!selectedSeatRow || !selectedSeatColumn"
          @click="purchaseTicket()"
        >
          <el-icon><CircleCheck /></el-icon>购买
        </el-button>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type Seat,
  type DealItem,
  type SeatItem,
  type PlaneItem,
  type TariffItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  searchForPlaneById,
  getPlaneDetails,
  purchaseTicket,
  searchPrice,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { type SpotItem } from '~/models/general';
import { CircleCheck,InfoFilled } from '@element-plus/icons-vue';

export default defineComponent ({
  name: 'NewSeatSelection' as string,
  components: {
    CircleCheck,
    InfoFilled,
  },
  props: {
    pId: {
      type: String,
      required: true
    },
    type: {
      type: String,
      required: true
    },
    airport1: {
      type: String,
      required: true
    },
    airport2: {
      type: String,
      required: true
    },
    tId: {
      type: Number,
      required: true
    },
  },

  watch: {
    pId: {
      immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.planeId = newVal;
      }
    },
    type: {
      //immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.seatType = newVal;
        this.getPrice(newVal);
      }
    },
    airport1: {
      immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.departureAirport = newVal;
      }
    },
    airport2: {
      immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.arrivalAirport = newVal;
      }
    },
    tId: {
      immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.travelRecordId = newVal;
      }
    },
    selectedSeatRow(newValue, oldValue) {
      this.getPrice(this.seatType); // 调用 getPrice 函数更新票价
    },
    selectedSeatColumn(newValue, oldValue) {
      this.getPrice(this.seatType); // 调用 getPrice 函数更新票价
    },
  },
  created() {
    this.planeId = Number(this.pId);
    this.seatType = this.type;
    this.departureAirport = this.airport1;
    this.arrivalAirport = this.airport2;
    this.travelRecordId = this.tId;
    console.log(this.travelRecordId);
  },
  async mounted() {
    await this.query();
    console.log(this.seatList);
    this.initSeatMap();
  },
  data: () => ({
      priceInfo: {} as TariffItem,
      travelRecordId: 0 as number,
      planeId: 0 as number,
      seatId: null as number | null,
      plane: {} as PlaneItem,
      departureAirport: "" as string,
      arrivalAirport: "" as string,
      selectedSeatRow: null as string | null,
      selectedSeatColumn: null as string | null,
      seatType: "" as string,
      totalSeats: 0 as number,
      emptySeats: 0 as number,
      seatRows: [] as Seat[][],
      seatList: [] as SeatItem[],
      occupiedSeats: [] as Seat[],  // Define occupiedSeats here and initialize as empty array
  }),
  /*async created(){
    console.log(this.planeId);
    const res = await getPlaneDetails(this.planeId);
    console.log(res.data);
    this.totalSeats = res.data.number_all;
    this.emptySeats = res.data.number_rest;
    this.seatList = res.data.seatList;
    //this.initSeatMap();
  },*/
methods: {
  async query(){
    const res = await getPlaneDetails(this.planeId);
    console.log(res.data);
    this.totalSeats = res.data.number_all;
    this.emptySeats = res.data.number_rest;
    this.seatList = res.data.seatList;
    console.log(this.seatList);
  },
  initSeatMap() {
    const rows = Math.ceil(this.totalSeats / 6);
    this.seatRows = [] as Seat[][];
    console.log(this.seatList);

    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; // 列号的字母表示

    for (let row = 1; row <= rows; row++) {
      const rowSeats = [] as Seat[];

      for (let col = 0; col < 6; col++) {
        const seatNumber = (row - 1) * 6 + col;
        const columnLabel = alphabet.charAt(col); // 根据索引获取字母
        const rowLabel = row.toString();

        // 查找对应座位信息
        const seatInfo = this.seatList.find(seat => seat.seatRowNumber === rowLabel && seat.seatColumnNumber === columnLabel && seat.isBooked);
        const disabled = !!seatInfo; // 如果找到对应座位信息，则为 true，表示座位已被预定

        rowSeats.push({ row: rowLabel, column: columnLabel, enabled: !disabled, disabled });
      }

      this.seatRows.push(rowSeats);
    }
    console.log(this.seatRows);
  },

  isSeatOccupied(row: string, column: string): boolean {
    return this.occupiedSeats.some(
      seat => seat.row === row && seat.column === column
    );
  },

  selectSeat(row: string, column: string) {
      this.selectedSeatRow = row;
      this.selectedSeatColumn = column;
    },

    isSelected(row: string, column: string): boolean {
      return this.selectedSeatRow === row && this.selectedSeatColumn === column;
    },

    async purchaseTicket() {
      console.log('购买座位：', this.selectedSeatRow, '排', this.selectedSeatColumn, '座');
      if (this.selectedSeatRow !== null && this.selectedSeatColumn !== null) {
        const selectedSeat = this.seatList.find(seat => seat.seatRowNumber === this.selectedSeatRow && seat.seatColumnNumber === this.selectedSeatColumn && !seat.isBooked);
        if (selectedSeat) {
          this.seatId = selectedSeat.seatId;
          if(this.priceInfo.price == null || this.priceInfo.price == undefined) {
            message(this, "请选择服务类型!");
            return;
          }
          // 将数据发送到后端
          let res = await purchaseTicket({
            travelRecordId: this.travelRecordId,
            seatId: this.seatId,
            planeId: this.planeId,
            price: this.priceInfo.price,
          });
          if (res.code != 0) {
            message(this, res.msg);
            return;
          } else {
            message(this, "购票成功！");
            this.query();
            this.$emit('submit', 1);
          }
        } else {
          message(this, "购票失败，请重试!");
        }
      }else {
        message(this, "行列号未选择！");
      }
    },

    async getPrice(seatType: string){
        let res = await searchPrice({
          seatType: seatType,
          planeId: this.planeId,
        });
        this.priceInfo = res.data.info;
        console.log(this.priceInfo);
        return;
    },
  },
});
</script>

<style scoped>
.seat-container {
  display: flex;
  flex-wrap: wrap; /* 自动换行 */
  justify-content: center; /* 控制每排座位在水平方向上的对齐方式 */
}

.row-header {
  display: flex;
  align-items: center;
  margin-right: 10px; /* 控制行号和座位之间的间距 */
}

.seat-button {
  width: 100px; /* 设置座位按钮的固定宽度 */
  height: 40px; /* 设置座位按钮的固定高度 */
  margin: 20px; /* 控制座位按钮之间的间距 */
}

.row-number {
  padding: 0 5px;
}

.seat-selection-container {
  display: flex;
  gap: 20px;
}

.seat-map {
  flex: 1;
  width: 60%;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 10px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  overflow-y: auto;
  overflow-x: auto;
}

.seat-row {
  display: flex;
  align-items: center;
  margin-bottom: 10px; /* 控制每行座位之间的间距 */
}

.seat-card {
  margin-right: 10px;
}

.aisle-text {
  font-size: 1.2em; /* 设置稍微大一些的字体大小 */
  font-weight: bold; /* 可选：加粗字体 */
  color: #333; /* 可选：设置字体颜色 */
  /* 可以根据需要添加其他样式，如字体家族、字间距等 */
}

button {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 4px;
  background-color: #f0f0f0;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button:disabled {
  background-color: #ddd;
  cursor: not-allowed;
}

.selected {
  background-color: #6fd24b !important;
  color: #fff;
}

.occupied {
  background-color: #f44336 !important;
  color: #fff;
}

.seat-info {
  display: flex;
  justify-content: space-between;
}

.seat-number {
  font-weight: bold;
}

.status {
  font-size: 12px;
  color: #666;
}

.seat-details {
  flex: 0 0 300px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  width: 40%;
}

form {
  margin-top: 20px;
}

form div {
  margin-bottom: 10px;
}

form button {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 4px;
  background-color: #007bff;
  color: #fff;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

form button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

form button:hover {
  background-color: #0056b3;
}
</style>
