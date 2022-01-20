import React, { FunctionComponent } from "react";
import styled from "@emotion/styled";

import colors from "colors/color";
import { css } from "@emotion/react";

type InputProps = {
	category: string;
	error?: boolean;
	onChange: React.ChangeEventHandler<HTMLInputElement>;
	onBlur?: React.ChangeEventHandler<HTMLInputElement>;
};

const placeholders = {
	email: "예) cream@cream.co.kr",
	password: "영문, 숫자, 특수문자 조합 8 ~ 16자",
	phone: "가입하신 휴대폰 번호",
};

const fieldTitle = {
	email: "이메일 주소",
	password: "비밀번호",
	phone: "핸드폰 번호",
};

const Input: FunctionComponent<InputProps> = (props) => {
	const { category, error = false, onChange, onBlur } = props;
	const placeholder = placeholders[category];
	return (
		<>
			<StyledInputTitle error={error}>{fieldTitle[category]}</StyledInputTitle>
			<StyledInput
				onChange={onChange}
				onBlur={onBlur}
				type={category}
				error={error}
				placeholder={placeholder}
			/>
			{error && (
				<>
					<ErrorMsg>🤔 {fieldTitle[category]} 형식을 확인해주세요!</ErrorMsg>
					<div style={{ paddingBottom: "30px" }}></div>
				</>
			)}
		</>
	);
};

export default Input;

const StyledInputTitle = styled.h3<{ error: boolean }>`
	font-size: 13px;
	letter-spacing: -0.07px;
	line-height: 18px;
	color: ${({ error }) =>
		error ? `${colors.colors.error}` : `${colors.colors.default}`};
`;

const StyledInput = styled.input<{ error: boolean }>`
	width: 400px;
	outline: 0;
	border-width: 0 0 1px;
	height: 38px;
	line-height: 22px;
	font-size: 15px;
	border-color: ${colors.borderColors.primary.disabled};
	:focus {
		border-color: ${colors.borderColors.primary.active};
	}
	::placeholder {
		color: ${colors.borderColors.primary.default};
	}
	${({ error }) =>
		error &&
		css`
			border-color: ${colors.colors.error};
			:focus {
				border-color: ${colors.colors.error};
			}
		`}
`;

const ErrorMsg = styled.p`
	color: ${colors.colors.error};
	display: block;
	position: absolute;
	line-height: 16px;
	font-size: 11px;
`;
