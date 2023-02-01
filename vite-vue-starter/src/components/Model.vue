<script setup>
defineProps(['modelValue'])
defineEmits(['update:modelValue'])
</script>

<template>
  <input
    :value="modelValue"
    placeholder="请输入地址"
    @input="$emit('update:modelValue', $event.target.value)"
  />
  <!-- <slot name="name"></slot> -->
  <slot name="header" message="插槽解构"></slot>
</template>