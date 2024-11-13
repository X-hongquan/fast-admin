<script setup>

import {onMounted, reactive, ref} from 'vue'
import {handleConfirmDel} from "@/utils/confirm.js";
import {deleteLoginLogAPI, listLoginLogAPI} from "@/api/system/loginLog.js";
import {deleteNotification} from "@/utils/notification.js";

const tableData = ref([])
//时间间隔
const value2 = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  ip: undefined,
  location: undefined,
  startTime: undefined,
  endTime: undefined
})

const total = ref(0)


function reset() {
  req.ip = undefined
  req.location = undefined
  req.startTime = undefined
  req.endTime = undefined
  value2.value = []
}

async function getLoginLogList() {
  if (value2.value.length == 2) {
    for (let i = 0; i < value2.value.length; i++) {
      req.startTime = value2.value[0]
      req.endTime = value2.value[1]
    }
  }
  const res = await listLoginLogAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

const selection = ref([])

function handleSelectionChange(val) {
  selection.value = val
}

function del() {
  handleConfirmDel(async () => {
        const ids = selection.value.map(item => item.id)
        const res = await deleteLoginLogAPI(ids)
        deleteNotification(res, () => {
          getLoginLogList()
        })
      }
  )
}


function handleSizeChange(val) {
  req.pageNum = 1
  getLoginLogList()
}

function handleCurrentChange(val) {
  getLoginLogList()
}


onMounted(() => {
  getLoginLogList()
})

</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <el-form-item label="ip地址">
          <el-input v-model="req.ip" placeholder="请输入ip地址" clearable></el-input>
        </el-form-item>
        <el-form-item label="位置">
          <el-input v-model="req.location" placeholder="请输入位置"></el-input>
        </el-form-item>
        <el-form-item label="调度时间">
          <div class="block">
            <el-date-picker
                v-model="value2"
                type="datetimerange"
                start-placeholder="Start date"
                end-placeholder="End date"
                value-format="YYYY-MM-DD HH:mm:ss"
            />
          </div>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getLoginLogList">查询</el-button>
      <el-button type="info" icon="refresh" @click="reset">重置</el-button>
      <el-button type="danger" icon="Delete" @click="del">删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column type="index" label="序号" width="80"></el-table-column>
      <el-table-column prop="ip" label="ip地址"></el-table-column>
      <el-table-column prop="location" label="地理位置"></el-table-column>
      <el-table-column prop="loginUser" label="登录用户"></el-table-column>
      <el-table-column prop="loginTime" label="登录时间"></el-table-column>
      <el-table-column prop="token" label="token"></el-table-column>
    </el-table>
    <div class="pagination-box">
      <el-pagination
          v-model:current-page="req.pageNum"
          v-model:page-size="req.pageSize"
          :page-sizes="[10,20,50,100]"
          layout="prev, pager, next,jumper,->, sizes,total"
          :total="total"
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </div>


  </div>
</template>

<style scoped lang="scss">

</style>
