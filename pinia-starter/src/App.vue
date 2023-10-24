<script setup>
import { storeToRefs } from 'pinia'
import { useUserStore } from './store/user'

const store = useUserStore()
const { role, data, getRole } = storeToRefs(store)
const header = ['姓名', '年龄', '住址']
// 更新角色
const updateRole = () => {
  store.role = 'vip'
}
// 重置角色
const resetRole = () => store.$reset()
// 批量修改
const patchRole = () => {
  console.log(store.$patch)
  store.$patch({
    role: 'role',
    data: [
      { name: '张三', age: 20, address: '重庆' },
      { name: '李四', age: 30, address: '南京' }
    ]
  })
}
</script>

<template>
  <div class="role">{{ getRole }}</div>
  <section>
    <button class="update" @click="updateRole">更新角色</button>
    <button class="reset mx" @click="resetRole">重置数据</button>
    <button class="reset" @click="patchRole">批量修改</button>
  </section>
  <main>
    <section>
      <div class="cell" v-for="item in header">
        {{ item }}
      </div>
    </section>
    <section class="list" v-for="item in data">
      <div class="cell" v-for="[_, v] in Object.entries(item)">
        {{ v }}
      </div>
    </section>
  </main>
</template>

<style lang="scss" scoped>
.role {
  font-size: .8em;
}
button {
  border: none;
  padding: 8px 4px;
  border-radius: 4px;
  cursor: pointer;
}
.mx {
  margin: 0 1em;
}
section {
  display: flex;
  .update {
    background-color: #088;
    color: white;
  }
  .reset {
    background-color: none;
    color: #000;
  }
}

main {
  display: flex;
  margin-top: 8px;
  flex-direction: column;
  flex-wrap: wrap;
  width: 400px;
  section {
    .cell {
      width: 33.3%;
      height: 30px;
      font-size: .8em;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
  section:nth-child(odd) {
    background-color: #088;
    color: white;
  }
}
</style>

