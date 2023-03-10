<script setup>
import { ref } from 'vue'
import { pathToBase64 } from '../../utils/file'

const img = ref('')
const choose = () => uni.chooseImage({
  count: 1,
  sourceType: ['album'],
  sizeType: ['compressed'],
  success: path => {
    pathToBase64(path.tempFilePaths[0]).then(base64 => img.value = base64)
  }
})
</script>

<template>
  <u-back />
  <view class="avatar-wrapper">
    <image class="avatar" :src="img || '/static/login/banana.png'" mode="aspectFill" />
    <view class="camera-wrapper">
      <image class="camera" src="/static/icons/camera.png" @tap="choose" />
    </view>
  </view>
</template>

<style lang="scss" scoped>
@mixin radius {
  position: absolute;
  border-radius: 50%;
  border: 3.85rpx solid rgba(255, 255, 255, 1);
}
.avatar-wrapper {
  width: 246rpx;
  height: 246rpx;
  margin: 123rpx auto 0 auto;
  position: relative;
  .avatar {
    display: block;
    width: 246rpx;
    height: 246rpx;
    @include radius;
  }
  .camera-wrapper {
    bottom: -20rpx;
    right: -20rpx;
    width: 92rpx;
    height: 92rpx;
    background-color: $color-green;
    z-index: 1;
    @include radius;
    .camera {
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      margin: 0 auto;
      z-index: 2;
      width: 46rpx;
      height: 46rpx;
    }
  }
}
</style>