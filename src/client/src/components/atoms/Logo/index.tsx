import React, { FunctionComponent } from "react";
import * as svg from "./svg";

type LogoProps = {
	category: string;
};

const Logo: FunctionComponent<LogoProps> = (props) => {
	const { category } = props;
	return React.createElement(svg[category]);
};

export default Logo;
