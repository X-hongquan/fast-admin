<script setup>
import {onMounted, onUnmounted, reactive, ref} from "vue";

import {ArrowRight} from "@element-plus/icons-vue";
import CodeBox from '@/components/CodeBox/index.vue'

import {addCacheAPI, delCacheAPI, infoCacheAPI, listCacheAPI} from "@/api/cache/index.js";
import {handleConfirmAdd, handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification} from "@/utils/notification.js";
import {useRouter} from "vue-router";


const router = useRouter()

const cacheEntity = reactive({
  value: undefined,
  key: undefined,
  expire: 3600
})

const keysObj = ref([])

async function getCacheKeys() {
  const res = await listCacheAPI()
  if (res.code === 200)
    keysObj.value = res.data
}


const dialog = ref(false)

function handleNodeInfo(data) {
  if (!data.children || data.children.length === 0)
    router.push({name: 'cacheInfo', params: {key: data.allKey}})
}

function handleNodeDelete(data) {
  handleConfirmDel(async () => {
    const res = await delCacheAPI(data)
    deleteNotification(res, () => {
      getCacheKeys()
    })
  })
}


function handleAddKey() {
  cacheEntity.value = undefined
  cacheEntity.key = undefined
  cacheEntity.expire = 3600
  dialog.value = true
}

async function addKey() {
  const res = await addCacheAPI(cacheEntity)
  addNotification(res, () => {
    getCacheKeys()
    dialog.value = false
  })
}

const times = ref(2)
let timesMy

function refresh() {
  timesMy = setInterval(() => {
    getCacheKeys()
  }, 1000 * times.value)
}

const autoRefresh = ref(true)

function stopRefresh() {
  if (timesMy) {
    clearInterval(timesMy)
    timesMy = undefined
    autoRefresh.value = false
  } else {
    refresh()
    autoRefresh.value = true
  }

}


refresh()
onMounted(() => {
  getCacheKeys()
})
onUnmounted(() => {
    clearInterval(timesMy)
})
</script>

<template>

  <div class="mt-box">
    <div class="key-box card-box">
      <el-form inline>
        <el-form-item label="自动刷新">
          <el-input v-model="times" type="number" :disabled="autoRefresh"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="stopRefresh" :type="autoRefresh?'danger':''">{{ autoRefresh ? '停止' : '启动' }}自动刷新
          </el-button>
        </el-form-item>
      </el-form>
      <el-tree
          style="max-width: 600px"
          :data="keysObj"
          node-key="allKey"
          default-expand-all
          :expand-on-click-node="false"
      >
        <template #default="{ node, data }">
        <span class="custom-tree-node" @click="handleNodeInfo(data)">
          <span>{{ node.key }}</span>
          <span>
            <el-button type="text" icon="Delete" @click="handleNodeDelete(data)"></el-button>
          </span>
        </span>
        </template>
      </el-tree>
    </div>
    <div class="key-btn" @click="handleAddKey">
      <el-icon size="80">
        <ArrowRight/>
      </el-icon>
    </div>
    <div class="value-box">
      <router-view></router-view>
    </div>
  </div>
  <el-dialog v-model="dialog" title="新增缓存" width="600">
    <el-form label-width="60">
      <el-form-item label="key">
        <el-input v-model="cacheEntity.key"></el-input>
      </el-form-item>
      <el-form-item label="value">
        <el-input v-model="cacheEntity.value" type="textarea" rows="10"></el-input>
      </el-form-item>
      <el-form-item label="expire">
        <el-input v-model="cacheEntity.expire" type="number"></el-input>
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="dialog=false">取 消</el-button>
      <el-button type="primary" @click="addKey">确 定</el-button>
    </template>
  </el-dialog>
</template>

<style scoped lang="scss">
.mt-box {
  display: flex;
  height: 100%;
  justify-content: center;


  .key-btn {
    display: flex;
    width: 100px;
    align-items: center;
    cursor: pointer;
    transition: .3s linear all;

    &:hover {
      color: #ff4949;
    }
  }

  .key-box {
    width: 600px;
  }

  .card-box {
    padding: 15px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    border-radius: 30px;

    .key-item {
      padding: 10px;
      cursor: pointer;
      transition: .3s linear all;

      &:hover {
        background-color: rgba(0, 0, 0, 0.1);
        color: #fff;
      }
    }
  }

  .value-box {
    flex: 1;
  }


}

.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}

</style>
