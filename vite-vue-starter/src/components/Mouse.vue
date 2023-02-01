<script lang="ts" setup>
import { useMouse } from '../utils/mouse'

const { x, y } = useMouse()
</script>

<template>
  <p>x: {{ x }}</p>
  <p>y: {{ y }}</p>
</template>