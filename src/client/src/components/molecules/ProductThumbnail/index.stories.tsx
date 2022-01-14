import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductThumbnail from ".";

export default {
	title: "molecules/ProductThumbnail",
	component: ProductThumbnail,
} as ComponentMeta<typeof ProductThumbnail>;

const Template: ComponentStory<typeof ProductThumbnail> = (args) => (
	<ProductThumbnail {...args}>{args.children}</ProductThumbnail>
);

export const Default = Template.bind({});
Default.args = {
	isInWishList: true,
};
