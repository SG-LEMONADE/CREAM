import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import { action } from "@storybook/addon-actions";

import QuickFilterBar from ".";

export default {
	title: "molecules/QuickFilterBar",
	component: QuickFilterBar,
} as ComponentMeta<typeof QuickFilterBar>;

const Template: ComponentStory<typeof QuickFilterBar> = (args) => (
	<QuickFilterBar {...args}>{args.children}</QuickFilterBar>
);

export const Default = Template.bind({});
Default.args = {
	onApplyFilter: (luxury: boolean, category: string) =>
		console.log(`럭셔리 필터는 ${luxury}로 하고, 상품 필터는 ${category}다.`),
};
