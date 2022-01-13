import React, { CSSProperties, FunctionComponent } from "react";

import * as svg from "./svg";

type LogoProps = {
	category: string;
	style?: CSSProperties;
};

const Logo: FunctionComponent<LogoProps> = (props) => {
	const { category, style } = props;
	return React.createElement(svg[category], { style });
};

export default Logo;
