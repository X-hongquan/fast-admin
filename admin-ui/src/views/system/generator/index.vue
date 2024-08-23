<script setup>
import {generateAPIGeneratorAPI, generateTypeJSGeneratorAPI, listGenerateAPI} from '@/api/generator.js'
import {onMounted, ref} from "vue";
import CodeBox from '@/components/CodeBox/index.vue'
import {ArrowUp} from "@element-plus/icons-vue";

const list = ref([])

async function downloadCode(mode) {
  let data
  let ext = ''
  switch (mode) {
    case 'api-js': {
      data = await generateAPIGeneratorAPI('js')
      ext = 'api.zip'
      break
    }
    case 'api-ts': {
      data = await generateAPIGeneratorAPI('ts')
      ext = 'api.zip'
      break
    }
    case 'type-js': {
      data = await generateTypeJSGeneratorAPI('js')
      ext = 'type.js'
      break
    }
    case 'type-ts': {
      data = await generateTypeJSGeneratorAPI('ts')
      ext = 'type.ts'
      break
    }
  }
  const htmlAnchorElement = document.createElement('a');
  let objectURL = URL.createObjectURL(data);
  htmlAnchorElement.href = objectURL;
  htmlAnchorElement.download = ext;
  htmlAnchorElement.click()
  htmlAnchorElement.remove()
}

async function getList() {
  const res = await listGenerateAPI()
  list.value = res.data
}

onMounted(() => {
  getList()
})
</script>

<template>
  <div class="content-box">
    <div class="operation-box">
      <el-button type="primary" @click="downloadCode('api-ts')">下载API-TS</el-button>
      <el-button type="primary" @click="downloadCode('api-js')">下载API-JS</el-button>
      <el-button type="primary" @click="downloadCode('type-js')">下载Type-JS</el-button>
      <el-button type="primary" @click="downloadCode('type-ts')">下载Type-TS</el-button>
    </div>
    <h1 id="tip"> 请使用CTRL+F搜素</h1>
    <a href="#tip"><el-icon><ArrowUp/></el-icon></a>
    <CodeBox v-for="item in list" :data="item.data" :header="item.fileName" :key="item.id"></CodeBox>
  </div>
</template>

<style scoped lang="scss">
a {

  position: fixed;
  text-align: center;
  width: 50px;
  height: 50px;
  line-height: 50px;
  font-size: 30px;
  z-index: 10;
  background-color: #ff4949;
  right: 0;
  top: 200px;


}
</style>
