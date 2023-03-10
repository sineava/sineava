<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'

const phone = ref('')
onLoad(prop => {
  phone.value = prop.phone
})
</script>

<template>
  <u-back />
  <view class="valid-wrapper">
    <span>验证您的手机</span>
    <view class="desc">请输入发送至<span class="strong">{{ phone }}</span>的4位验证码</view>
    <u-valid />
  </view>
</template>

<style lang="scss" scoped>
.valid-wrapper {
  padding: 0 46rpx;
  font-size: 24px;
  margin-top: 92rpx;
  .desc {
    margin-top: 12rpx;
    font-size: 16px;
    .strong {
      color: $color-green;
      margin: 0 12rpx;
    }
  }
}
</style>
