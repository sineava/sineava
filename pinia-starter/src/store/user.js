import { defineStore } from 'pinia'

const roles = new Map([['admin', '管理员'], ['role', '普通用户'], ['vip', '会员']])

export const useUserStore = defineStore('user', {
  state: () => ({
    role: 'admin',
    data: [
      { name: 'zs', age: 20, address: '重庆' },
      { name: 'ls', age: 18, address: '北京' }
    ]
  }),
  getters: {
    getRole: state => roles.get(state.role)
  }
})