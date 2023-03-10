<script setup>
import { reactive, computed } from 'vue'

const form = reactive({ phone: '18323285322', password: '123' })
const flag = computed(() => !!(form.phone && form.password))
const login = () => {
  if (!flag.value) return
  uni.navigateTo({ url: `/pages/login/valid?phone=${form.phone}` })
}
</script>

<template>
  <scroll-view class="top-wrapper">
    <view class="circle-left"></view>
    <view class="circle-right"></view>
    <image class="banana" src="/static/login/banana.png" mode="widthFix" />
    <image class="yingtao" src="/static/login/yingtao.png" mode="widthFix" />
    <image class="qiezi" src="/static/login/qiezi.png" mode="widthFix" />
  </scroll-view>
  <view class="title-wrapper">
    <image class="title" src="/static/login/title.png" mode="widthFix" />
    <view class="process">
      <template v-for="i in 4" :key="i">
        <view :class="`step-indicator ${i === 3 && 'current'}`"></view>
      </template>
    </view>
  </view>
  <view class="account-wrapper">
    <form>
      <label>
        账号
        <image class="icon" src="/static/icons/phone.png" mode="heightFix" />
        <input class="input account" v-model="form.phone" type="tel" placeholder="手机号" />
      </label>
      <label>
        密码
        <image class="icon" src="/static/icons/lock.png" mode="heightFix" />
        <input class="input" type="password" v-model="form.password" placeholder="字母、数字或符号,6-24位" />
      </label>
    </form>
    <view class="sure-wrapper">
      <checkbox class="ck" />
      <view class="sure">已阅读同意<span class="highlight">《服务条款》</span>和<span class="highlight">《隐私权政策》</span>。</view>
    </view>
    <button :class="`g-btn ${flag && 'okay'}`" @click="login">登录</button>
    <span class="tip">如果你没有账号,那么将为您直接注册</span>
  </view>
</template>

<style lang="scss" scoped>
.top-wrapper {
  width: 100%;
  height: 560rpx;
  .yingtao {
    width: 246rpx;
    top: 85rpx;
    left: 46rpx;
    position: absolute;
  }
  .banana {
    width: 246rpx;
    top: 296rpx;
    left: 252rpx;
    position: absolute;
  }
  .qiezi {
    width: 123rpx;
    top: 235rpx;
    right: 46rpx;
    position: absolute;
  }
  .circle-left {
    top: -187rpx;
    left: -187rpx;
    width: 373rpx;
    height: 373rpx;
    @include circle;
  }
  .circle-right {
    top: 85rpx;
    left: 429rpx;
    width: 550rpx;
    height: 550rpx;
    @include circle;
  }
}
.title-wrapper {
  .title {
    display: block;
    width: 433rpx;
    margin: 0 auto;
  }
  .process {
    margin-top: 77rpx;
    display: flex;
    justify-content: center;
    .step-indicator {
      width: 46rpx;
      height: 8rpx;
      margin: 8rpx;
      border-radius: 15.38rpx;
      background-color: $color-grey;
      &.current {
        background-color: $color-green;
      }
    }
  }
}
.account-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 14px;
  margin-top: 46rpx;
  .icon {
    @include icon;
  }
  .input{
    @include input;
    &:nth-child(1) {
      margin-bottom: 46rpx;
    }
  }
  .sure-wrapper {
    margin-top: 46rpx;
    width: 658rpx;
    display: flex;
    align-items: center;
    font-size: 14px;
    .ck {
      width: 38rpx;
    }
    .sure {
      margin-left: 31rpx;
      .highlight {
        color: $color-green;
      }
    }
  }
  .tip {
    font-size: 14px;
    margin-top: 46rpx;
    font-weight: 500;
    color: rgba(68, 77, 67, 1);
  }
}
</style>