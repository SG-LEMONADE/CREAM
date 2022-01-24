import React, { FunctionComponent, useEffect, useState } from "react";
import styled from "@emotion/styled";

import Icon from "components/atoms/Icon";

type CheckBoxProps = {
	defaultChecked?: boolean;
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<HTMLLabelElement>;
};

const CheckBox: FunctionComponent<CheckBoxProps> = (props) => {
	const { defaultChecked = false, children, onClick } = props;
	const [checked, setChecked] = useState<boolean>(defaultChecked);

	useEffect(() => {
		setChecked(defaultChecked);
	}, [checked]);

	return (
		<Wrapper onClick={onClick} checked={checked} data-content={children}>
			{children}
			<Input
				onClick={(e) => {
					e.stopPropagation();
					setChecked(!checked);
				}}
				type="checkbox"
				defaultChecked={checked}
				checkedState={checked}
			/>
			<CheckMark checked={checked}>
				<Icon name="Check" />
			</CheckMark>
		</Wrapper>
	);
};

export default CheckBox;

const Wrapper = styled.label<{ checked: boolean }>`
	display: block;
	position: relative;
	font-size: 14px;
	padding-left: 27px;
	cursor: pointer;
	width: 100%;
	font-weight: ${({ checked }) => checked && "700"};
`;

const Input = styled.input<{ checkedState: boolean }>`
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
	${({ checkedState }) =>
		checkedState
			? `+ span {
			background-color: black;
		}`
			: `+ span {
			background-color: white
		}`}
`;

const CheckMark = styled.span<{ checked: boolean }>`
	position: absolute;
	top: 0;
	left: 0;
	height: 17px;
	width: 17px;
	background-color: #fff;
	border: 1px solid rgba(34, 34, 34, 0.5);
	border-radius: 4px;
	text-align: center;
	transition: all 300ms;
	> svg {
		visibility: ${({ checked }) => (checked ? "visible" : "hidden")};
	}
`;
