import React, { FunctionComponent, useCallback, useState } from "react";
import { useRouter } from "next/router";
import Link from "next/link";
import axios from "axios";

import Logo from "components/atoms/Logo";
import Input from "components/atoms/Input";
import Button from "components/atoms/Button";
import { setToken } from "utils/token";
import { validateEmailFormat } from "utils/validate";

import styled from "@emotion/styled";

const LoginForm: FunctionComponent = () => {
	const router = useRouter();

	const [email, setEmail] = useState<string>("");
	const [password, setPassword] = useState<string>("");
	const [isErrorEmail, setIsErrorEmail] = useState<boolean>(false);
	const [isErrorPwd] = useState<boolean>(false);

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

	const onHandleLogin = async (e: React.MouseEvent<HTMLButtonElement>) => {
		e.preventDefault();
		try {
			const res = await axios.post(
				`${process.env.END_POINT_USER}/users/login`,
				{
					email: email,
					password: password,
				},
			);
			const data = await res.data;
			setToken("accessToken", data.accessToken);
			setToken("refreshToken", data.refreshToken);
			router.push("/");
		} catch (err) {
			const errResponse = err.response.data;
			errResponse.code &&
				alert(process.env.ERROR_code[parseInt(errResponse.code)]);
		}
	};

	return (
		<LoginContainer>
			<LoginContents>
				<LoginArea>
					<Logo category="LogowithTag" />
					{isErrorEmail ? (
						<Input
							onChange={onValidateEmailFormat}
							category="email"
							error
							content="이메일 주소"
						/>
					) : (
						<Input
							onChange={onValidateEmailFormat}
							category="email"
							content="이메일 주소"
						/>
					)}
					<form>
						<Input
							onChange={(e) => setPassword(e.target.value)}
							category="password"
							content="비밀번호"
						/>
						<ButtonArea>
							{isErrorEmail ||
							isErrorPwd ||
							email.length === 0 ||
							password.length === 0 ? (
								<Button
									onClick={onHandleLogin}
									category="primary"
									fullWidth
									disabled
								>
									로그인
								</Button>
							) : (
								<Button onClick={onHandleLogin} category="primary" fullWidth>
									로그인
								</Button>
							)}
							<LookBox>
								<LookList>
									<Link href={"/join"}>
										<StyledA>이메일 가입</StyledA>
									</Link>
								</LookList>
								<LookList>
									<Link href={"/login/find_email"}>
										<StyledA>이메일 찾기</StyledA>
									</Link>
								</LookList>
								<LookList>
									<Link href={"/login/find_password"}>
										<StyledA>비밀번호 찾기</StyledA>
									</Link>
								</LookList>
							</LookBox>
						</ButtonArea>
					</form>
				</LoginArea>
			</LoginContents>
		</LoginContainer>
	);
};

export default LoginForm;

const LoginContainer = styled.div`
	margin: 0;
	padding: 0;
	padding-top: 100px;
`;

const LoginContents = styled.div`
	margin: 0 auto;
	padding: 0 40px;
	max-width: 1280px;
`;

const LoginArea = styled.div`
	margin: 0 auto;
	padding: 60px 0 160px;
	width: 400px;
`;

const ButtonArea = styled.div`
	padding-top: 45px;
`;

const LookBox = styled.ul`
	margin-top: 25px;
	display: flex;
	justify-content: space-evenly;
	list-style: none;
`;

const LookList = styled.li`
	display: inline-flex;
	align-items: flex-start;
	flex: 1;
	&: after {
		content: "";
		margin-top: 2px;
		display: inline-block;
		width: 1px;
		height: 14px;
		background-color: #d3d3d3;
        margin-left: 20px;
	}
	&: last-child: after {
		display: none;
	}
`;

const StyledA = styled.a`
	padding: 0 10px;
	display: inline-flex;
	font-size: 13px;
	letter-spaceing: -0.07px;
	text-decoration: none;
	cursor: pointer;
`;
