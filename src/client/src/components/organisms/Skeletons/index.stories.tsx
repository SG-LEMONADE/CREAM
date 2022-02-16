import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductSkeleton from ".";

export default {
	title: "organisms/ProductSkeleton",
	component: ProductSkeleton,
} as ComponentMeta<typeof ProductSkeleton>;

const Template: ComponentStory<typeof ProductSkeleton> = (args) => (
	<ProductSkeleton {...args}>{args.children}</ProductSkeleton>
);

export const Default = Template.bind({});
Default.args = {};
