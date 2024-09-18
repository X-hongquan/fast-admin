<script setup>
import {onMounted, ref} from 'vue'
import {useTransition} from '@vueuse/core'
import {ChatLineRound, Male} from '@element-plus/icons-vue'
import * as echarts from 'echarts';
import {useSocketStore} from "@/store/socket.js";
import {
  getLoginCountByMonthStatisticsAPI,
  getLoginCountByTodayStatisticsAPI,
  getLoginCountByYearStatisticsAPI
} from "@/api/statistics.js";

const store = useSocketStore()
const todayLoginCount = ref(0)
const monthLoginCount = ref(0)
const yearLoginCount = ref(0)
const loginRef = ref(null)
const userRef = ref(null)


function startLoginChart() {
  const loginChart = echarts.init(loginRef.value)
  const option = {
    series: [
      {
        type: 'pie',
        data: [
          {
            value: 335,
            name: '直接访问'
          },
          {
            value: 234,
            name: '联盟广告'
          },
          {
            value: 1548,
            name: '搜索引擎'
          }
        ]
      }
    ]
  }
  loginChart.setOption(option)
}

function startUserChart() {
  const userChart = echarts.init(userRef.value)
  const option = {
    title: {
      text: 'ECharts 入门示例'
    },
    tooltip: {},
    xAxis: {
      data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
    },
    yAxis: {},
    series: [
      {
        name: '销量',
        type: 'bar',
        data: [5, 20, 36, 10, 10, 20]
      }
    ]
  }
  userChart.setOption(option)
}


const outputValue = useTransition(monthLoginCount, {
  duration: 1500,
})


async function getTodayLoginCount() {
  const res = await getLoginCountByTodayStatisticsAPI()
  if (res.code === 200) {
    todayLoginCount.value = res.data
  }
}

async function getMonthLoginCount() {
  const res = await getLoginCountByMonthStatisticsAPI()
  if (res.code === 200) {
    monthLoginCount.value = res.data
  }
}

async function getYearLoginCount() {
  const res = await getLoginCountByYearStatisticsAPI()
  if (res.code === 200) {
    yearLoginCount.value = res.data
  }
}

onMounted(() => {
  getTodayLoginCount()
  getMonthLoginCount()
  getYearLoginCount()
  startLoginChart()
  startUserChart()

})
</script>


<template>
  <el-row>
    <el-col :span="6">
      <el-statistic title="在线用户" :value="store.onlineCount"/>
    </el-col>
    <el-col :span="6">
      <el-statistic title="今日登录次数" :value="todayLoginCount">
      </el-statistic>
    </el-col>
    <el-col :span="6">
      <el-statistic title="本月共登录次数" :value="outputValue"/>
    </el-col>
    <el-col :span="6">
      <el-statistic title="今年登录次数" :value="yearLoginCount">
        <template #suffix>
          <el-icon style="vertical-align: -0.125em">
            <ChatLineRound/>
          </el-icon>
        </template>
      </el-statistic>
    </el-col>
  </el-row>

  <el-row style="margin-top: 100px">
    <el-col :span="12">
      <div class="left-box" ref="loginRef"></div>
    </el-col>
    <el-col :span="12">
      <div class="right-box" ref="userRef"></div>
    </el-col>
  </el-row>

</template>

<style scoped lang="scss">
.el-col {
  text-align: center;
}

.left-box, .right-box {
  width: 100%;
  height: 600px;
}
</style>
