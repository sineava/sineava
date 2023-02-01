<script lang="ts" setup>
import { ref } from 'vue'

const num = ref(1)
const add = () => num.value++
</script>

<template>
  <button @click="add">{{ num }}</button>
</template>