import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import { action } from "@storybook/addon-actions";

import Modal from ".";
import Input from "components/atoms/Input";

export default {
	title: "molecules/Modal",
	component: Modal,
} as ComponentMeta<typeof Modal>;

const Template: ComponentStory<typeof Modal> = (args) => (
	<Modal {...args}>{args.children}</Modal>
);

export const SelectShoeSizeModal = Template.bind({});
SelectShoeSizeModal.args = {
	category: "else",
	show: true,
	onClose: action("closed"),
	children: <h4>Test</h4>,
	title: "Title",
};

export const WishModal = Template.bind({});
WishModal.args = {
	category: "wish",
	show: true,
	onClose: action("closed"),
	children: <h4>Test</h4>,
	title: "Title",
};

export const SearchModal = Template.bind({});
SearchModal.args = {
	category: "search",
	show: true,
	children: <Input category="search" content="검색어를 입력하세요" />,
	title: "제품 찾기",
};
