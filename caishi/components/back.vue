<script setup>
const back = uni.navigateBack
</script>

<template>
  <view class="header-wrapper" @tap="back">
    <image class="back" src="/static/icons/back.png" mode="heightFix" />
    <span class="desc">返回</span>
  </view>
</template>

<style lang="scss" scoped>
.header-wrapper {
  padding: 119rpx 0 0 65rpx;
  box-sizing: border-box;
  // margin: 119rpx 0 0 65rpx;
  display: flex;
  align-items: center;
  .back {
    height: 15rpx;
  }
  .desc {
    margin-left: 19rpx;
    font-size: 14px;
  }
}
</style>