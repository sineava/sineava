<script lang="ts" setup>
import { useCounterStore } from './stores'
// import { provide } from 'vue'
// import Child from './components/Child.vue'
// import { key } from './utils/index'

// provide(key, '你拿不到')
// import { ref } from 'vue'
// import Model from './components/Model.vue'
// import Mouse from './components/Mouse.vue'
// const address = ref('')
// import Counter from './components/Counter.vue'
// import Error from './components/Error.vue'
// import Fetch from './components/Fetch.vue'
// import ToRef from './components/ToRef.vue'

const counter = useCounterStore()
console.log(counter)
</script>

<template>
  111
  <!-- <ToRef /> -->
  <!-- <Counter /> -->
  <!-- <Error class="top" /> -->
  <!-- <Fetch /> -->
  <!-- <Model v-model="address">
    <template #header="{message}">{{  message  }}</template>
  </Model>
  <p>{{ address }}</p> -->
  <!-- <Mouse />
  <Teleport to="body">
    <div>2233</div>
  </Teleport> -->
  <!-- <Child name="child" /> -->
</template>