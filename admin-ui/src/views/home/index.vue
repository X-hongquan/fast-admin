<script setup>
import { getTimes } from '@/utils/time';
import {useUserStore} from '@/store/user';
import setting from '/setting.js'
import SvgIcon from '@/components/SvgIcon/index.vue'

console.log(1)
const userStore = useUserStore();

</script>


<template>
  <el-card>
    <div class="box">
      <img :src="userStore.userInfo.user.avatar" alt="" class="avatar">
      <div class="bottom">
        <h3 class="title">{{ getTimes() }},{{ userStore.userInfo.user.username }}</h3>
        <p class="subtitle">{{setting.logoTitle}}</p>
        <el-link type="primary" href="https://chqwz.top/" target="_blank" style="font-size: 20px">项目地址</el-link>
        <p style="height: 20px"></p>
        <el-link type="primary" href="http://114.132.249.233/" target="_blank" style="font-size: 20px" >文档地址</el-link>
      </div>
    </div>
  </el-card>
  <div class="bottoms">
    <SvgIcon name="welcome" width="600px" height="300px"></SvgIcon>
  </div>

</template>



<style scoped lang="scss">
.box {
  display: flex;

  .avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
  }

  .bottom {
    margin-left: 20px;

    .title {
      font-size: 30px;
      font-weight: 900;
      margin-bottom: 30px;
    }

    .subtitle {
      font-style: italic;
      color: skyblue;
    }
  }
}
.bottoms{
  margin-top: 10px;
  display: flex;
  justify-content: center;
}
</style>
