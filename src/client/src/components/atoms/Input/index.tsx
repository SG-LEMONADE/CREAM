import React, { FunctionComponent } from "react";
import Icon from "../Icon";

import colors from "colors/color";

import { css } from "@emotion/react";
import styled from "@emotion/styled";

type InputProps = {
	defaultvalue?: string;
	category: string;
	content: string;
	error?: boolean;
	onChange?: React.ChangeEventHandler<HTMLInputElement>;
	onBlur?: React.ChangeEventHandler<HTMLInputElement>;
	onClick?: () => void;
	required?: boolean;
};

const placeholders = {
	email: "예) cream@cream.co.kr",
	password: "영문, 숫자, 특수문자 조합 8 ~ 16자",
	phone: "가입하신 휴대폰 번호",
	sneakers: "선택하세요",
	search: "브랜드명, 모델명, 모델번호 등",
	name: "고객님의 이름",
};

const Input: FunctionComponent<InputProps> = (props) => {
	const {
		defaultvalue,
		category,
		content,
		error = false,
		onChange,
		onBlur,
		onClick,
		required = false,
	} = props;

	/** For Code Review
	 * 아래의 StyledInput에게 cateogory를 부여하여 재사용성을 늘렸습니다.
	 * error의 여부에 따라 색을 다르게 조정하여 사용자에게 오류가 있음을 알려줍니다.
	 */
	return (
		<>
			<StyledInputTitle error={error} required={required}>
				{content}
			</StyledInputTitle>
			<StyledInput
				defaultValue={defaultvalue}
				onChange={onChange}
				onBlur={onBlur}
				onClick={onClick}
				category={category}
				type={category}
				error={error}
				placeholder={placeholders[category]}
			/>
			{category === "sneakers" && (
				<Icon
					name="ChevronRight"
					style={{
						width: "15px",
						height: "15px",
						color: "#222222",
						display: "inline-block",
						position: "absolute",
						right: 0,
					}}
				/>
			)}
			{error && (
				<>
					<ErrorMsg>🤔 {content} 형식을 확인해주세요!</ErrorMsg>
					<div style={{ paddingBottom: "30px" }}></div>
				</>
			)}
		</>
	);
};

export default Input;

const StyledInputTitle = styled.h3<{ error: boolean; required: boolean }>`
	font-size: 13px;
	letter-spacing: -0.07px;
	line-height: 18px;
	color: ${({ error }) =>
		error ? `${colors.colors.error}` : `${colors.colors.default}`};
	:after {
		${({ required }) =>
			required &&
			`content: " *";
		top: -2px;
		right: 0;`}
	}
`;

const StyledInput = styled.input<{ error: boolean; category: string }>`
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
	${({ category }) => category === "sneakers" && `cursor: pointer`}
`;

const ErrorMsg = styled.p`
	color: ${colors.colors.error};
	display: block;
	position: absolute;
	line-height: 16px;
	font-size: 11px;
`;
