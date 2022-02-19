import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import ProductImage from "./";

export default {
	title: "atoms/ProductImage",
	component: ProductImage,
} as ComponentMeta<typeof ProductImage>;

const Template: ComponentStory<typeof ProductImage> = (args) => (
	<ProductImage {...args} />
);

export const HomeImage = Template.bind({});
HomeImage.args = {
	src: "https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjIg/MDAxNjI3NDQxMDA1NjE5.HOgIYywGZaaBJDqUzx2OnX9HAxoOWPvuWHqUn_LZGcgg.VYIuOfA5_GgjBGRowv6dmQuAOPtUvmAxbGpOyUCOCtYg.PNG/p_9d8ed1a74d2540ab9842e63363607bf4.png?type=m",
	category: "home",
	backgroundColor: "rgb(235, 240, 245)",
};

export const ShopImage = Template.bind({});
ShopImage.args = {
	src: "https://kream-phinf.pstatic.net/MjAyMTExMTZfMzkg/MDAxNjM3MDQzMzM0MzUz.94K4SoFB9IWLnLRh2iUXjWN0s53ADBEfhwIQQVC_kbAg.4Xl3LXELbnhDdMl8Vz0RdUF7JdQzk_LYyhOHIDvIQUgg.PNG/a_d38d4d9403c34c7c9f4f52bf2ce4f649.png?type=m",
	category: "shop",
	backgroundColor: "rgb(246, 238, 237)",
};

export const ProductItemImage = Template.bind({});
ProductItemImage.args = {
	src: "https://kream-phinf.pstatic.net/MjAyMTEyMTBfMjQ4/MDAxNjM5MTEyMTE4ODk3.E5xSNEGfpoeBSUdiEb1TiK0xB8pQZ2sbsmKwir2X0H0g.N-57P9OD7r27nsWNs_0AwgF6CJAO7GrokL22BCeS7QUg.PNG/a_40f9f33ce83747cba477269413bee1f0.png?type=m",
	category: "product",
	backgroundColor: "rgb(241, 241, 234)",
};
