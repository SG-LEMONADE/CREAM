import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductThumbnailImage from ".";

export default {
	title: "molecules/ProductThumbnailImage",
	component: ProductThumbnailImage,
} as ComponentMeta<typeof ProductThumbnailImage>;

const Template: ComponentStory<typeof ProductThumbnailImage> = (args) => (
	<ProductThumbnailImage {...args}>{args.children}</ProductThumbnailImage>
);

export const Default = Template.bind({});
Default.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTExMTZfMzkg/MDAxNjM3MDQzMzM0MzUz.94K4SoFB9IWLnLRh2iUXjWN0s53ADBEfhwIQQVC_kbAg.4Xl3LXELbnhDdMl8Vz0RdUF7JdQzk_LYyhOHIDvIQUgg.PNG/a_d38d4d9403c34c7c9f4f52bf2ce4f649.png?type=m",
	backgroundColor: "rgb(246, 238, 237)",
	isInWishList: true,
};
