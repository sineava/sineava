<script lang="ts" setup>
import { ref, inject } from 'vue'
import { key } from '../utils/index'
import type { Ref } from 'vue'

const value = inject(key)
let val: Ref<string | number> = ref(1)
const { name, age = 20, address = '北京' } = defineProps<{
  name: string
  age?: number
  address?: string
}>()

if (true /** diff */) {

}

val.value = 'sss'
</script>

<template>
  {{ name }} {{ age }} {{ address }} {{ val }} {{ value }}
</template>