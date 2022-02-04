import React, { FunctionComponent, CSSProperties } from "react";

import * as svg from "./svg";

export type IconTypes = keyof typeof svg;

type IconProps = {
	name: IconTypes;
	style?: CSSProperties;
	onClick?: React.MouseEventHandler<SVGSVGElement> | any;
};

const Icon: FunctionComponent<IconProps> = (props) => {
	const { name, style, onClick } = props;
	return React.createElement(svg[name], { style, onClick });
};

export default Icon;
