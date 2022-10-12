<template>
  <button @click="add">
    click me add salary
  </button>

  <p>码农薪水: {{ obj.salary }}</p>
  <p>码农地址: {{ obj.address }}</p>
</template>

<script setup>
import { toRefs, reactive } from 'vue'
const obj = reactive({ salary: 0, address: '无家可归' })
// const targetRef = {
//   salary: toRef(obj, 'salary')
// }
const targetRef = toRefs(obj)
// convert normal obj to ref obj
const add = () => {
  targetRef['salary'].value += 1
  targetRef['address'].value = '北京'
}
</script>