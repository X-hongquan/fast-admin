<script setup>
import {ref, reactive, onMounted, nextTick} from "vue";
import {
  getRoleListAPI,
  deleteRoleAPI,
  getRoleAPI,
  updateRoleAPI,
  addRoleAPI,
  assignRolePermissionsAPI, assignRoleMenusAPI
} from "@/api/role/index.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";
import {getPermissionListAPI} from "@/api/permission/index.js";
import {getMenuListAPI} from "@/api/menu/index.js";
import {preHandleMenu} from "@/utils/init.js";

let roleId
const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  name: undefined,
  roleId: undefined,
  status: undefined
})

function resetReq() {
  req.name = undefined
}

const menuProps = {
  children: 'children',
  label: 'title',
}

const mode = ref(false)
const title = ref('')

const role = reactive({
  id: undefined,
  name: undefined,
  createBy: undefined,
  createTime: undefined,
  updateBy: undefined,
  updateTime: undefined
})


const total = ref(0)

const selections = ref([])

/**
 * 选定函数
 * @param {role[]} val
 * @returns {Promise<void>}
 */
async function handleSelectionChange(val) {
  selections.value = val
}

async function getRoleList() {
  const res = await getRoleListAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

function del(ids) {
  handleConfirmDel(async () => {
    const res = await deleteRoleAPI(ids)
    deleteNotification(res, () => {
      getRoleList()
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
  getRoleList()
}

function handleCurrentChange(val) {
  getRoleList()
}

function resetForm() {
  role.id = undefined
  role.name = undefined
}

function handleAdd() {
  resetForm()
  mode.value = true
  title.value = '新增角色'
}

async function handleUpdate(row) {
  resetForm()
  mode.value = true
  title.value = '编辑角色'
  const res = await getRoleAPI(row.id)
  Object.assign(role, res.data)

}

//权限抽屉
const permissionDrawer = ref(false)
//菜单抽屉
const menuDrawer = ref(false)
const drawTitle = ref('')
const direction = ref('rtl')


const permissions = ref([])
const selectionPermissions = ref([])


const selectionMenus = ref([])
const menus = ref([])

const menuTree = ref(null)

let menuMap


async function handleAssignMenu(row) {
  menuDrawer.value = true
  drawTitle.value = '分配菜单'
  roleId = row.id
  const res = await getMenuListAPI({pageSize: 500})
  if (res.code === 200) {
    const {arr, map} = preHandleMenu(res.data)
    menus.value = arr
    menuMap = map
  }
  const r = await getMenuListAPI({pageSize: 500, roleId: row.id == 1 ? undefined : row.id})
  if (res.code === 200) {
    const arr = r.data
    const d = arr.map(item => item.id)
    selectionMenus.value = d
    console.log(selectionMenus.value)
    await nextTick()
    let that = menuTree.value
    //todo没展开问题
    that.setCheckedKeys(selectionMenus.value)

  }
}

async function handleAssignPermission(row) {
  roleId = row.id
  permissionDrawer.value = true
  drawTitle.value = '分配权限'
  const res = await getPermissionListAPI({pageSize: 500})
  if (res.code === 200) {
    permissions.value = res.data
  }

  const r = await getPermissionListAPI({pageSize: 500, roleId: row.id == 1 ? undefined : row.id})
  if (res.code === 200) {
    const arr = r.data
    selectionPermissions.value = arr.map(item => item.id)
  }
}


async function submitAssignPermission() {
  let p = {
    roleId: roleId,
    permissionIds: selectionPermissions.value
  }
  const res = await assignRolePermissionsAPI(p)
  updateNotification(res, () => {
    permissionDrawer.value = false
  })
}


async function submitAssignMenu() {
  let p = {
    roleId: roleId,
    menuIds: selectionMenus.value
  }
  const res = await assignRoleMenusAPI(p)
  updateNotification(res, () => {
    menuDrawer.value = false
  })
}

async function submit() {
  if (role.name && role.name.trim()) {
    if (role.id) {
      const res = await updateRoleAPI(role)
      updateNotification(res, () => {
        getRoleList()
        mode.value = false
      })
    } else {
      const res = await addRoleAPI(role)
      addNotification(res, () => {
        getRoleList()
        mode.value = false
      })
    }
  } else {
    ElMessage.error('请输入角色名')
  }
}

function makeParentChecked(val) {
  if (val.parentId === '0')
    return
  const menu = menuMap.get(val.parentId)
  let find = selectionMenus.value.find(item => item === menu.id);
  if (!find) {
    selectionMenus.value.push(menu.id)
    makeParentChecked(menu)
  }
}

function makeSonUnChecked(val) {
  const menu = menuMap.get(val.id)
  if (menu.children && menu.children.length > 0) {
    selectionMenus.value = selectionMenus.value.filter(item => {
      const m = menuMap.get(item)
      return item !== menu.id && m.parentId !== menu.id
    })
    for (let i = 0; i < menu.children.length; i++) {
      makeSonUnChecked(menu.children[i])
    }
  }
}

async function handleCheckMenu(val, data) {
  if (data.checkedKeys.length > selectionMenus.value.length) {
    makeParentChecked(val)
    selectionMenus.value.push(val.id)
  } else {
    if (val.children)
      makeSonUnChecked(val)
    else
      selectionMenus.value = data.checkedKeys
  }
  menuTree.value.setCheckedKeys(selectionMenus.value)

}


onMounted(() => {
  getRoleList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <el-form-item label="角色">
          <el-input v-model="req.name" placeholder="请输入角色名"></el-input>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getRoleList">查询</el-button>
      <el-button type="info" icon="Refresh" @click="resetReq">重置</el-button>
      <el-button type="primary" icon="Plus" @click="handleAdd">新增</el-button>
      <el-button type="danger" icon="Delete" @click="deleteBatch">批量删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="用户名" type="index" width="80"></el-table-column>
      <el-table-column label="角色名" prop="name"></el-table-column>
      <el-table-column prop="createBy" label="创建人"></el-table-column>
      <el-table-column prop="createTime" label="创建时间"></el-table-column>
      <el-table-column label="操作">
        <template #default="{row}">
          <el-button type="text" icon="Menu" @click="handleAssignMenu(row)">分配菜单</el-button>
          <el-button type="text" icon="UserFilled" @click="handleAssignPermission(row)">分配权限</el-button>
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
      <el-form :model="role" label-width="80px">
        <el-form-item label="角色名" required>
          <el-input v-model="role.name"></el-input>
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

  <el-drawer v-model="permissionDrawer" :direction="direction">
    <template #header>
      <h4>{{ drawTitle }}</h4>
    </template>
    <template #default>
      <div>
        <el-checkbox-group v-model="selectionPermissions" size="large">
          <el-checkbox :value="item.id" :label="item.description" size="large"
                       border
                       v-for="item in permissions" :key="item.id"/>
        </el-checkbox-group>

      </div>
    </template>
    <template #footer>
      <div style="flex: auto">
        <el-button @click="permissionDrawer=false">cancel</el-button>
        <el-button type="primary" @click="submitAssignPermission">confirm</el-button>
      </div>
    </template>
  </el-drawer>


  <el-drawer v-model="menuDrawer" :direction="direction">
    <template #header>
      <h4>{{ drawTitle }}</h4>
    </template>
    <template #default>
      <div>
        <el-tree
            style="max-width: 600px"
            :data="menus"
            :props="menuProps"
            ref="menuTree"
            node-key="id"
            show-checkbox
            check-strictly
            @check="handleCheckMenu"
            highlight-current
        />

      </div>
    </template>
    <template #footer>
      <div style="flex: auto">
        <el-button @click="menuDrawer=false">cancel</el-button>
        <el-button type="primary" @click="submitAssignMenu">confirm</el-button>
      </div>
    </template>
  </el-drawer>
</template>

<style scoped lang="scss">

</style>
