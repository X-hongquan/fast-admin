<script setup>
import {ref, reactive, onMounted} from "vue";
import {
  getMenuListAPI,
  deleteMenuAPI,
  getMenuAPI,
  updateMenuAPI,
  addMenuAPI
} from "@/api/menu/index.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";
import {preHandleMenu} from "@/utils/init.js";
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

let icons = Object.keys(ElementPlusIconsVue)


const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  roleId: undefined,
  status: undefined
})
function resetReq() {
  req.status = undefined
  req.roleId = undefined
}
const mode = ref(false)
const title = ref('')
const menus = ref([])
const menu = reactive({
  id: undefined,
  name: undefined,
  parentId: undefined,
  component: undefined,
  url: undefined,
  sort: undefined,
  title: undefined,
  level: undefined,
  type: undefined,
  icon: undefined,
  status: undefined,
  redirect: undefined,
  link: undefined,
})


const total = ref(0)
const selections = ref([])
const lock = ref(false)

async function handleSelectionChange(val) {
  selections.value = val
}

async function getMenuList() {
  const res = await getMenuListAPI(req)
  if (res.code === 200) {
    menus.value = res.data
    const {arr} = preHandleMenu(res.data)
    tableData.value = arr
    total.value = Number(res.total)
  }
}

function del(ids) {
  handleConfirmDel(async () => {
    const res = await deleteMenuAPI(ids)
    deleteNotification(res, () => {
      getMenuList()
    })
  })
}

function deleteOne(row) {
  del([row.id])
}

function deleteBatch() {
  if (selections.value.length > 0) {
    del(selections.value.map((item) => item.id))
  } else {
    ElMessage.error('请选择要删除的数据')
  }
}

function handleSizeChange(val) {
  req.pageNum = 1
  getMenuList()
}

function handleCurrentChange(val) {
  getMenuList()
}

function resetForm() {
  Object.keys(menu).forEach((key) => menu[key] = undefined)
  lock.value = false
  menu.status = 1
  menu.parentId = 0
}

function handleAdd() {
  resetForm()
  mode.value = true
  title.value = '新增菜单'
}

function handAddLevel(row) {
  resetForm()
  mode.value = true
  title.value = '新增菜单'
  menu.parentId = row.id
  lock.value = true
  menu.level = row.level + 1
}

async function handleUpdate(row) {
  resetForm()
  mode.value = true
  title.value = '编辑菜单'
  const res = await getMenuAPI(row.id)
  Object.assign(menu, res.data)

}

async function submit() {
  if (menu.id) {
    const res = await updateMenuAPI(menu)
    updateNotification(res, () => {
      getMenuList()
      mode.value = false
    })
  } else {
    const res = await addMenuAPI(menu)
    addNotification(res, () => {
      getMenuList()
      mode.value = false
    })
  }
}

onMounted(() => {
  getMenuList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <el-form-item label="状态" prop="status" class="input-width">
          <el-select v-model="req.status" placeholder="请选择状态" clearable >
            <el-option label="启用" :value="1"></el-option>
            <el-option label="禁用" :value="0"></el-option>
          </el-select>
        </el-form-item>
      </el-form>

    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getMenuList">查询</el-button>
      <el-button type="info" icon="Refresh" @click="resetReq">重置</el-button>
      <el-button type="primary" icon="Plus" @click="handleAdd">新增</el-button>
      <el-button type="danger" icon="Delete" @click="deleteBatch">批量删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange" row-key="id">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="序号" type="index" width="80"></el-table-column>
      <el-table-column label="标题" prop="title"></el-table-column>
      <el-table-column label="类型" prop="type">
        <template #default="{row}">
          <el-tag v-if="row.type === 0" type="success">目录</el-tag>
          <el-tag v-else-if="row.type === 1" type="danger">菜单</el-tag>
          <el-tag v-else type="warning">其他</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="路径" prop="url"></el-table-column>
      <el-table-column label="组件" prop="component"></el-table-column>
      <el-table-column label="图标" prop="icon">
        <template #default="{row}">
          <el-icon size="large">
            <component :is="row.icon"></component>
          </el-icon>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="300">
        <template #default="{row}">
          <el-button type="text" icon="Plus" @click="handAddLevel(row)">新增菜单</el-button>
          <el-button type="text" icon="Edit" @click="handleUpdate(row)">编辑</el-button>
          <el-button type="text" icon="Delete" @click="deleteOne(row)">删除</el-button>
        </template>
      </el-table-column>
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
    <el-dialog v-model="mode" :title="title">
      <el-form :model="menu" label-width="80px">
        <el-row gutter="30">
          <el-col :span="12">
            <el-form-item label="标题" prop="title" required>
              <el-input v-model="menu.title" placeholder="请输入标题"></el-input>
            </el-form-item>
          </el-col>
          <el-col span="12">
            <el-form-item label="父级菜单" required>
              <el-select v-model="menu.parentId" placeholder="请选择父级菜单" :disabled="lock" class="input-width">
                <el-option label="根目录" :value="0"></el-option>
                <el-option v-for="item in menus" :key="item.id" :label="item.title" :value="item.id"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="类型">
          <el-radio-group v-model="menu.link">
            <el-radio :label="0">非外链</el-radio>
            <el-radio :label="1">外链</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-row gutter="30">
          <el-col :span="12">
            <el-form-item label="组件">
              <el-input v-model="menu.component" placeholder="请输入组件路径"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="路由名称" required>
              <el-input v-model="menu.name" placeholder="请输入名称"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="路径" required>
          <el-input v-model="menu.url" placeholder="请输入路径"></el-input>
        </el-form-item>
        <el-form-item label="层级" required>
          <el-input v-model="menu.level" placeholder="请输入层级" :disabled="lock"></el-input>
        </el-form-item>
        <el-form-item label="排序">
          <el-input v-model="menu.sort" placeholder="请输入排序" :disabled="lock"></el-input>
        </el-form-item>
        <el-form-item label="重定向">
          <el-input v-model="menu.redirect" placeholder="请输入重定向路径"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="menu.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="类型">
          <el-radio-group v-model="menu.type">
            <el-radio :label="0">目录</el-radio>
            <el-radio :label="1">菜单</el-radio>
            <el-radio :label="2">其他</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="图标">
          <el-select v-model="menu.icon" placeholder="请选择图标"
                     size="large" style="width: 200px">
            <el-option v-for="item in icons" :key="item" :label="item" :value="item">
              <el-icon size="large">
                <component :is="item"></component>
              </el-icon>
            </el-option>
          </el-select>
          <el-icon style="font-size: 40px">
            <component :is="menu.icon"></component>
          </el-icon>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="mode = false">取 消</el-button>
          <el-button type="primary" @click="submit">确 定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">

</style>
