<script setup>
import {CopyDocument} from "@element-plus/icons-vue";
import {ref} from "vue";
import {ElMessage} from "element-plus";

const prop=defineProps({
  data: {
    type:String,
    default:''
  }
})
const CodeDiv = ref(null)

function copyText() {
  navigator.clipboard.writeText(prop.data).then(function() {
    ElMessage({
      message: '复制成功',
      type: 'success',
      duration: 1000
    })
  }).catch(e=>{

  })

}
</script>

<template>
<div class="code-box" ref="CodeDiv">
  <span>{{data}}</span>
  <el-tooltip content="复制" >
    <div class="cb-cp" @click="copyText"> <el-icon><CopyDocument /></el-icon></div>
  </el-tooltip>
 </div>
</template>

<style scoped lang="scss">
.code-box {
  position: relative;
  white-space: pre;
  background-color: #1f1f1f;
  font-family: "Consolas", monospace; /* 代码字体 */
  border-radius: 5px;
  font-size: 20px;
  line-height: 25px;
  padding: 15px;
  color: #9bd8ed;
  border: 1px solid #ccc;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);

  .cb-cp {
    position: absolute;
    right: 10px;
    top: 10px;
    padding: 5px;
    cursor: pointer;
  }
  .cb-cp:hover {
    background-color: #fff;
    color: #000;
  }

}
</style>
