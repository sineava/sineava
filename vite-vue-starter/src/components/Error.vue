<script setup>
console.log(window)
const variable = null
const err = () => {
  throw new Error('自定义异常')
}
</script>

<template>
  <button disabled @click="err">点击抛异常</button>
  <span v-pre>{{ hello world }}</span>
  <span v-show="false">show</span>
  <span :[variable]="'variable为null则不渲染'"></span>
</template>