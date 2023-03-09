<template>
	<view>
		<button open-type="chooseAvatar" @chooseavatar="getAvatar">获取头像</button>
		<button open-type="chooseAddress" @tap="getAddress">选择收获地址</button>
		<text selectable>长按选中</text>
		<image :src="img"></image>
		<swiper class="swiper" indicator-dots>
			<swiper-item>
				<view class="item">1</view>
			</swiper-item>
			<swiper-item>
				<view class="item">2</view>
			</swiper-item>
			<swiper-item>
				<view class="item">3</view>
			</swiper-item>
		</swiper>
		<view class="container" @tap="tap('div', $event)">
			<button size="mini" type="warn" @tap="tap('button', $event)">按钮1</button>
		</view>
		<view v-for="i in 20">
			<view>{{ i }}</view>
		</view>
		<u-toast />
	</view>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { onReachBottom } from '@dcloudio/uni-app'

const img = ref('')
const getAvatar = (e: any) => img.value = e.target.avatarUrl
const getAddress = () => {
	uni.authorize({
		 scope: 'scope.address',
		 success: () => {
			uni.chooseAddress({
			  success(res) {
				console.log(res)
			  }
			})
		 }
	})
}
const tap = (type: 'div' | 'button', e: Event) => {
	console.log(e, wx)
	e.stopPropagation()
	console.log(`点击了${type}`)
}
onReachBottom(() => {
	// wx.showLoading({ title: 'loading加载中' })
	console.log('触底')
})
</script>

<style>
.swiper {
	height: 200px;
}
.item {
	background-color: cyan;
	height: 100%;
}
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: seagreen;
}
</style>
