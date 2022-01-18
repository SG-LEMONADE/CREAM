import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductDeliveryInfo from "./";

export default {
	title: "Molecules/ProductDeliveryInfo",
	component: ProductDeliveryInfo,
} as ComponentMeta<typeof ProductDeliveryInfo>;

const Template: ComponentStory<typeof ProductDeliveryInfo> = (args) => (
	<ProductDeliveryInfo {...args}>{args.children}</ProductDeliveryInfo>
);

export const Default = Template.bind({});
Default.args = {};
