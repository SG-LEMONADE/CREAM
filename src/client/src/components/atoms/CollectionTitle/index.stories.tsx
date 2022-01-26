import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import CollectionTitle from ".";

export default {
	title: "atoms/CollectionTitle",
	component: CollectionTitle,
} as ComponentMeta<typeof CollectionTitle>;

const Template: ComponentStory<typeof CollectionTitle> = (args) => (
	<CollectionTitle {...args}>{args.children}</CollectionTitle>
);

export const Default = Template.bind({});
Default.args = {
	title: "New In",
	subTitle: "신규 등록 상품",
};

export const OnlyTitle = Template.bind({});
OnlyTitle.args = {
	title: "구매내역",
};
