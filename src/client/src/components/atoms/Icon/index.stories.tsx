import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import Icon from "./";

export default {
	title: "atoms/Icon",
	component: Icon,
	args: {
		style: { cursor: "pointer" },
	},
} as ComponentMeta<typeof Icon>;

const Template: ComponentStory<typeof Icon> = (args) => <Icon {...args} />;

export const Magnifier = Template.bind({});
Magnifier.args = {
	name: "Magnifier",
};

export const Close = Template.bind({});
Close.args = {
	name: "Close",
};

export const Bookmark = Template.bind({});
Bookmark.args = {
	name: "Bookmark",
};

export const BookmarkFilled = Template.bind({});
BookmarkFilled.args = {
	name: "BookmarkFilled",
};

export const Sort = Template.bind({});
Sort.args = {
	name: "Sort",
};

export const Plus = Template.bind({});
Plus.args = {
	name: "Plus",
};

export const Minus = Template.bind({});
Minus.args = {
	name: "Minus",
};

export const Filter = Template.bind({});
Filter.args = {
	name: "Filter",
};

export const CaretUp = Template.bind({});
CaretUp.args = {
	name: "CaretUp",
};

export const CaretDown = Template.bind({});
CaretDown.args = {
	name: "CaretDown",
};

export const ChevronLeft = Template.bind({});
ChevronLeft.args = {
	name: "ChevronLeft",
};

export const ChevronRight = Template.bind({});
ChevronRight.args = {
	name: "ChevronRight",
};

export const ChevronDown = Template.bind({});
ChevronDown.args = {
	name: "ChevronDown",
};

export const Question = Template.bind({});
Question.args = {
	name: "Question",
};

export const Profile = Template.bind({});
Profile.args = {
	name: "Profile",
};

export const Check = Template.bind({});
Check.args = {
	name: "Check",
};
