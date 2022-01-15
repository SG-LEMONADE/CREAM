import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ShortcutItem from ".";

export default {
	title: "atoms/ShortcutItem",
	component: ShortcutItem,
} as ComponentMeta<typeof ShortcutItem>;

const Template: ComponentStory<typeof ShortcutItem> = (args) => (
	<ShortcutItem {...args}>{args.children}</ShortcutItem>
);

export const Default = Template.bind({});
Default.args = {
	src: "https://kream-phinf.pstatic.net/MjAyMjAxMTRfMjgw/MDAxNjQyMTU5MTU3NjM5.p89ur4TcB7U6IJLE2GJEMtMfYbCgQwjiPkjccxdsJ3kg.DzCb0EY9KMVSa-bbu9mwwPTP7He_inHbnkz6EXB7x2Mg.JPEG/a_3e2d573f7ab04f319d05837caa8ccf2c.jpg?type=m",
	link: "/",
	title: "럭키 드로우",
};
