import React, { CSSProperties, FunctionComponent } from "react";

import styled from "@emotion/styled";
import { Color, css } from "@emotion/react";
import colors from "colors/color";

type ButtonTypes = keyof Color["buttonTextColors"];

type ButtonProps = {
	category: ButtonTypes;
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<HTMLButtonElement>;
	disabled?: boolean;
	fullWidth?: boolean;
	style?: CSSProperties;
};

const Button: FunctionComponent<ButtonProps> = (props) => {
	const {
		category,
		children,
		onClick,
		disabled = false,
		fullWidth = false,
		style,
	} = props;
	return (
		<StyledButton
			category={category}
			onClick={onClick}
			disabled={disabled}
			fullWidth={fullWidth}
			style={style}
		>
			{typeof children === "number"
				? `${children.toLocaleString()}원`
				: children}
		</StyledButton>
	);
};

export default Button;

const StyledButton = styled.button<{
	category: ButtonTypes;
	disabled: boolean;
	fullWidth: boolean;
}>`
	textalign: center;
	padding: 0 30px;
	height: 42px;
	line-height: 40px;
	border-radius: 12px;
	font-size: 14px;
	cursor: pointer;
	border-style: solid;
	font-weight: 800;
	color: ${({ category, disabled }) =>
		disabled
			? colors.buttonTextColors[category].disabled
			: colors.buttonTextColors[category].default};
	background: ${({ category, disabled }) =>
		disabled
			? colors.buttonBgColors[category].disabled
			: colors.buttonBgColors[category].default};
	border-color: ${({ category, disabled }) =>
		disabled
			? colors.borderColors[category].disabled
			: colors.borderColors[category].default};
	&:hover:enabled {
		color: ${({ category }) => colors.buttonTextColors[category].hover};
		background: ${({ category }) => colors.buttonBgColors[category].hover};
		border-color: ${({ category }) => colors.borderColors[category].hover};
	}
	&:active:enabled {
		color: ${({ category }) => colors.buttonTextColors[category].active};
		background: ${({ category }) => colors.buttonBgColors[category].active};
		border-color: ${({ category }) => colors.borderColors[category].active};
	}
	${({ category, disabled, fullWidth }) =>
		fullWidth &&
		css`
			width: 100%;
			background: ${disabled ? "#ebebeb" : "rgba(34, 34, 34)"};
			background: ${category !== "primary" &&
			(category === "buy" ? "#ef6153" : "#41b979")};
			color: white;
			border-color: ${disabled ? "#ebebeb" : "rgba(34, 34, 34)"};
			border-color: ${category !== "primary" &&
			(category === "buy" ? "#ef6153" : "#41b979")};
			&:hover:enabled {
				transition: 0.5s;
			}
		`}
`;
