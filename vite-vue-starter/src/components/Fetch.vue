<script lang="ts" setup>
import { ref, watch, watchEffect } from 'vue'

const key = ref('')
const user: any = ref({})

// watch(key, async (newVal) => {
//   if (newVal) {
//     user.value = await (fetch(`https://jsonplaceholder.typicode.com/todos/${key.value}`).then(res => res.json()))
//   }
// })

watchEffect(async () => {
  key.value && (user.value = await (fetch(`https://jsonplaceholder.typicode.com/todos/${key.value}`).then(res => res.json())))
})
</script>

<template>
<input v-model="key" />
<p>{{ user?.title }}</p>
</template>