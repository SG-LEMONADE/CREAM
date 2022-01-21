import React, { FunctionComponent, useState } from "react";
import styled from "@emotion/styled";

import Icon from "components/atoms/Icon";

type CheckBoxProps = {
	children: React.ReactNode;
	onClick?: React.MouseEventHandler<HTMLLabelElement>;
};

const CheckBox: FunctionComponent<CheckBoxProps> = (props) => {
	const { children, onClick } = props;
	const [checked, setChecked] = useState<boolean>(false);

	return (
		<Wrapper onClick={onClick} checked={checked} data-content={children}>
			{children}
			<Input
				onClick={() => setChecked(!checked)}
				type="checkbox"
				defaultChecked={checked}
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

const Input = styled.input`
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
	:checked + span {
		background-color: black;
	}
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
