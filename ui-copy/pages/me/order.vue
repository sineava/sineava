<template>
	<view class="bg">
		<view class="bg-container">
			<view class="bg-left-radius radius"></view>
			<view class="bg-right-radius radius"></view>
			<view class="user-info">
				<image src="../../static/me/avatar.png" mode="widthFix" class="avatar"></image>
				<view class="phone-info">
					<text class="phone">{{ phone }}</text>
					<view class="progress-bar" :style="{'--percent': `${percent * 100}%`}"></view>
					<view class="percent">{{ percent * 100 }}/100</view>
				</view>
			</view>
			<view class="card-wrapper">
				<view v-for="item, i in list" :key="i" class="card-item" hover-class="card-item-active">
					<image :src="`../../static/me/${item}.png`" mode="heightFix"></image>
					<text>{{ ['地址', '订单', '消息', '电话'][i] }}</text>
				</view>
			</view>
		</view>
		<view class="banner"></view>
		<view v-for="arr, i in tabs" :key="i" class="profile">
			<view class="profile-item" v-for="item,j in arr" :key="`${i}-${j}`" hover-class="profile-item-active">
				<view class="item-left">
					<image :src="`../../static/me/${item.icon}.png`" class="item-icon" mode="heightFix" />
					<text class="item-title">{{item.text}}</text>
				</view>
				<view classs="item-right">
					<image src="../../static/me/next.png" class="item-icon" mode="heightFix" />
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			phone: '183****5322',
			percent: 18/40,
			list: ['address', 'order', 'message', 'phone'],
			tabs: [
				[
					{ text: '扫身份码', icon: 'code' },
					{ text: '历史订单', icon: 'history' },
					{ text: '收藏订单', icon: 'save' }
				],
				[
					{ text: '分享给好友', icon: 'share' },
					{ text: '快递工厂', icon: 'factory' },
					{ text: '天气查询', icon: 'weather' },
					{ text: '给我们点赞', icon: 'awesome' }
				]
			]
		}
	}
}
</script>

<style lang="scss" scoped>
@mixin card {
	width: 100%;
	height: 164rpx;
	border-radius: 16rpx;
}
.bg {
	padding: 16rpx;
}	
.bg-container {
	width: 100%;
	position: relative;
}
.radius {
	position: absolute;
	width: 306rpx;
	height: 306rpx;
	border-radius: 50%;
	filter: blur(100px);
}
.bg-left-radius {
	left: 0;
	top: 0;
	background-color: #d2fcfc;
}
.bg-right-radius {
	right: -100rpx;
	top: -100rpx;
	background-color: #f5d3fc;
}
.user-info {
	display: flex;
	.avatar {
		width: 112rpx;
	}
	.phone-info {
		margin-left: 22rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		.phone {
			font-weight: bolder;
			font-size: 28rpx;
		}
		.progress-bar {
			width: 354rpx;
			height: 8rpx;
			background-color: red;
			border-radius: 8rpx;
			position: relative;
			background-color: rgba(58, 136, 255, 0.3);;
			&::after {
				content: '';
				width: var(--percent);
				height: 100%;
				left: 0;
				top: 0;
				background-color: #3a88ff;
				position: absolute;
				border-radius: 8rpx;
			}
		}
		.percent {
			font-size: 24rpx;
		}
	}
}
.card-wrapper {
	display: flex;
	align-items: center;
	background-color: #fff;
	margin: 16rpx auto;
	@include card;
	.card-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		width: 25%;
		height: 100%;
		image {
			height: 48rpx;
		}
		text {
			margin-top: 8rpx;
			font-size: 24rpx;
		}
	}
	.card-item-active {
		background-color: #eee;
	}
}

.banner {
	margin: 16rpx auto 30rpx;
	background-image: url('../../static/me/receive.png');
	background-size: cover;
	transform: scale(1.04);
	@include card;
}

.profile {
	background-color: #fff;
	border-radius: 8rpx;
	margin-bottom: 24rpx;
	.profile-item {
		display: flex;
		justify-content: space-between;
		padding: 32rpx;
		.item-left {
			display: flex;
			align-items: center;
			.item-title {
				margin-left: 32rpx;
				font-size: 30rpx;
			}
		}
		.item-right {
			display: flex;
		}
		.item-icon {
			height: 40rpx;
		}
	}
	.profile-item-active {
		background-color: #f6f6f6;
	}
}
</style>