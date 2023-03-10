<script setup>
import { ref } from 'vue'

const code = ref([])
const current = ref(0)
const trigger = (e, i) => {
  const val = e.detail.value
  code.value[i] = val
  current.value = val ? ++i : --i
}
const valid = () => {
  const data = code.value.join('')
  if (data === '1234') {
    uni.navigateTo({ url: '/pages/login/profile' })
  }
}
</script>

<template>
  <view class="wrapper">
    <input v-for="_, i in 4" :key="i" :class="`valid ${code[i] && 'active'}`" maxlength="1" type="number" :focus="i === current" @input="$event => trigger($event, i)" />
  </view>
  <button v-if="current === 4" :class="`btn g-btn okay`" @tap="valid">验证</button>
</template>

<style lang="scss" scoped>
.wrapper {
  display: flex;
  justify-content: space-evenly;
  .valid {
    font-size: 24px;
    line-height: 185rpx;
    width: 138rpx;
    height: 185rpx;
    text-align: center;
    caret-color: transparent;
    border-bottom: 4rpx solid rgba(204, 214, 203, 1);
    user-select: none;
    &.active {
      border-bottom: 4rpx solid rgba(105, 194, 97, 1);
    }
  }
}
.btn {
  margin-top: 658rpx;
}
</style>