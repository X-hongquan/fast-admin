<script setup>
import {generateAPIGeneratorAPI, generateTypeJSGeneratorAPI} from '@/api/generator.js'


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
      ext = 'dto.js'
      break
    }
    case 'type-ts': {
      data = await generateTypeJSGeneratorAPI('ts')
      ext = 'model.ts'
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

</script>

<template>
  <div class="content-box">
    <div class="operation-box">
      <el-button type="primary" @click="downloadCode('api-js')">下载APITS</el-button>
      <el-button type="primary" @click="downloadCode('api-ts')">下载APIJS</el-button>
      <el-button type="primary" @click="downloadCode('type-js')">下载TypeJS</el-button>
      <el-button type="primary" @click="downloadCode('type-ts')">下载TypeTS</el-button>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>
