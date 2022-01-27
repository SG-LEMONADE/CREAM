import React, { FunctionComponent, useCallback, useState } from "react";
import axios from "axios";
import { useRouter } from "next/router";

import Input from "components/atoms/Input";
import Button from "components/atoms/Button";
import Modal from "components/molecules/Modal";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import { validateEmailFormat, validatePwdFormat } from "utils/validate";

import styled from "@emotion/styled";
import Swal from "sweetalert2";

const JoinForm: FunctionComponent = () => {
	const router = useRouter();

	const [isOpen, setIsOpen] = useState<boolean>(false);

	const [email, setEmail] = useState<string>("");
	const [password, setPassword] = useState<string>("");
	const [size, setSize] = useState<string>("");
	const [isErrorEmail, setIsErrorEmail] = useState<boolean>(false);
	const [isErrorPwd, setIsErrorPwd] = useState<boolean>(false);

	const onValidateEmailFormat = useCallback(
		(e: React.ChangeEvent<HTMLInputElement>) => {
			const inputEmail = e.target.value;
			const validateResult = validateEmailFormat(inputEmail);
			setIsErrorEmail(!validateResult);
			if (validateResult) {
				setEmail(inputEmail);
				setIsErrorEmail(false);
			}
		},
		[],
	);

	const onValidatePwdFormat = useCallback(
		(e: React.ChangeEvent<HTMLInputElement>) => {
			const inputPwd = e.target.value;
			const validateResult = validatePwdFormat(inputPwd);
			setIsErrorPwd(!validateResult);
			if (validateResult) {
				setPassword(inputPwd);
				setIsErrorPwd(false);
			}
		},
		[],
	);

	const onHandleJoin = async (e: React.MouseEvent<HTMLButtonElement>) => {
		e.preventDefault();
		console.log(email, password, size);
		try {
			const res = await axios.post(`${process.env.END_POINT}/users/signup`, {
				email: email,
				password: password,
				shoeSize: size,
			});
			const data = await res.data;
			console.log(data);
			Swal.fire({
				position: "top",
				icon: "success",
				html: `가입하신 이메일로 인증 메일을 보냈습니다.<br/><br/>
            인증 후 다시 로그인해주세요.`,
				showConfirmButton: false,
				timer: 2000,
			});
			router.push("/");
		} catch (err) {
			const errResponse = err.response.data;
			errResponse.code &&
				Swal.fire({
					position: "top",
					icon: "error",
					html: `${process.env.ERROR_code[parseInt(errResponse.code)]}`,
					showConfirmButton: false,
					timer: 2000,
				});
		}
	};

	return (
		<JoinContainer>
			<JoinContents>
				<JoinArea>
					<StyledTitle>회원 가입</StyledTitle>
					<InputBox>
						{isErrorEmail ? (
							<Input
								category="email"
								content="이메일 주소"
								required
								onChange={onValidateEmailFormat}
								error
							/>
						) : (
							<Input
								category="email"
								content="이메일 주소"
								required
								onChange={onValidateEmailFormat}
							/>
						)}
					</InputBox>
					<InputBox>
						{isErrorPwd ? (
							<Input
								category="password"
								content="비밀번호"
								required
								onChange={onValidatePwdFormat}
								error
							/>
						) : (
							<Input
								category="password"
								content="비밀번호"
								required
								onChange={onValidatePwdFormat}
							/>
						)}
					</InputBox>
					<InputBox>
						<Input
							defaultvalue={size}
							category="sneakers"
							content="스니커즈 사이즈"
							required
							onClick={() => setIsOpen(true)}
						/>
					</InputBox>
					<ButtonArea>
						{email.length === 0 ||
						password.length === 0 ||
						size.length === 0 ||
						isErrorEmail ||
						isErrorPwd ? (
							<Button category="primary" fullWidth disabled>
								가입하기
							</Button>
						) : (
							<Button category="primary" fullWidth onClick={onHandleJoin}>
								가입하기
							</Button>
						)}
					</ButtonArea>
				</JoinArea>
			</JoinContents>
			<Modal
				category="wish"
				onClose={() => setIsOpen(false)}
				show={isOpen}
				title="관심 상품 추가"
			>
				<ProductSizeSelectGrid
					activeSizeOption={size}
					category="sizeOnly"
					onClick={setSize}
				/>
			</Modal>
		</JoinContainer>
	);
};

export default JoinForm;

const JoinContainer = styled.div`
	margin: 0;
	padding: 0;
`;

const JoinContents = styled.div`
	margin: 0 auto;
	padding: 0 40px;
	max-width: 1280px;
`;

const JoinArea = styled.div`
	margin: 0 auto;
	padding: 58px 0 160px;
	width: 400px;
`;

const StyledTitle = styled.h2`
	padding-bottom: 42px;
	text-align: center;
	font-size: 32px;
	letter-spacing: -0.48px;
	color: #000;
`;

const InputBox = styled.div`
	position: relative;
	padding: 10px 0 14px;
`;

const ButtonArea = styled.div`
	padding-top: 45px;
`;
