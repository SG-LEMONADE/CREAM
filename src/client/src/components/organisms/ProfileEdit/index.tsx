import React, {
	FunctionComponent,
	useCallback,
	useContext,
	useEffect,
	useState,
} from "react";
import { useSWRConfig } from "swr";
import axios from "axios";
import UserContext from "context/user";
import DaumPostcode, { Address } from "react-daum-postcode";

import Button from "components/atoms/Button";
import Modal from "components/molecules/Modal";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import Input from "components/atoms/Input";

import styled from "@emotion/styled";

type ProfileEditProps = {
	email: string;
	name: null | string;
	address: null | string;
	shoeSize: string;
};

type PostProps = {
	setIsOpenKakao: React.Dispatch<React.SetStateAction<boolean>>;
	cb: (address: string) => void;
};

const Post: FunctionComponent<PostProps> = (props) => {
	const { setIsOpenKakao, cb } = props;

	const onCompletePost = (data: Address) => {
		console.log(data.address);
		cb(data.address);
		setIsOpenKakao(false);
	};

	return (
		<>
			<DaumPostcode autoClose onComplete={onCompletePost} />
		</>
	);
};

const ProfileEdit: FunctionComponent<ProfileEditProps> = (props) => {
	const { user } = useContext(UserContext);

	const { mutate } = useSWRConfig();

	const { email, name, address, shoeSize } = props;

	const [isOpen, setIsOpen] = useState<boolean>(false);
	const [isOpenKakao, setIsOpenKakao] = useState<boolean>(false);
	const [isOpenNameInput, setIsOpenNameInput] = useState<boolean>(false);
	const [isOpenPwdInput, setIsOpenPwdInput] = useState<boolean>(false);

	const [newPwd, setNewPwd] = useState<string>("");
	const [newAddress, setNewAddress] = useState<string>("");
	const [newShoeSize, setNewShoeSize] = useState<string>(shoeSize);

	const trimEmail = useCallback(
		(email: string) => {
			const atIndex = email.indexOf("@");
			if (atIndex === -1) return;
			return `${email[0]}${"*".repeat(atIndex - 2)}${
				email[atIndex - 1]
			}${email.slice(atIndex)}`;
		},
		[email],
	);

	const putUserInfo = useCallback(async (address: string) => {
		try {
			// const res = await axios.put(`/users/id`, {
			// 	address: address,
			// 	age: 0,
			// 	email: email,
			// 	gender: true,
			// 	name: name,
			// 	password: "string",
			// 	profileImageUrl: "string",
			// 	shoeSize: 0,
			// });
			// const data = res.data;
		} catch (e) {
			console.error(e);
		}
	}, []);

	return (
		<ProfileEditWrapper>
			<LoginInfo>
				<SubTitle>로그인 정보</SubTitle>
				<FieldItem>
					<StyledInputTitle activated={false}>이메일 주소</StyledInputTitle>
					<StyledP activated={false}>{trimEmail(email)}</StyledP>
					<ButtonWrapper>
						<Button disabled category="primary">
							변경
						</Button>
					</ButtonWrapper>
				</FieldItem>
				<FieldItem>
					<StyledInputTitle activated={true}>비밀번호</StyledInputTitle>
					{isOpenPwdInput ? (
						<>
							<NewInputWrapper>
								<Input category="password" content="새로운 비밀번호" />
							</NewInputWrapper>
							<ChangeButtonWrapper>
								<Button
									onClick={() => setIsOpenPwdInput(false)}
									category="primary"
								>
									취소
								</Button>
								<Button
									onClick={() => console.log(user)}
									style={{ marginLeft: "10px" }}
									category="primary"
								>
									확인
								</Button>
							</ChangeButtonWrapper>
						</>
					) : (
						<>
							<StyledP activated>●●●●●●●●●</StyledP>
							<ButtonWrapper>
								<Button
									onClick={() => setIsOpenPwdInput(true)}
									category="primary"
								>
									변경
								</Button>
							</ButtonWrapper>
						</>
					)}
				</FieldItem>
			</LoginInfo>
			<PersonalInfo>
				<SubTitle>개인 정보</SubTitle>
				<FieldItem>
					<StyledInputTitle activated={true}>이름</StyledInputTitle>
					{isOpenNameInput ? (
						<>
							<NewInputWrapper>
								<Input category="name" content="새로운 이름" />
							</NewInputWrapper>
							<ChangeButtonWrapper>
								<Button
									onClick={() => setIsOpenNameInput(false)}
									category="primary"
								>
									취소
								</Button>
								<Button style={{ marginLeft: "10px" }} category="primary">
									확인
								</Button>
							</ChangeButtonWrapper>
						</>
					) : (
						<>
							<StyledP activated={name !== null}>
								{name === null ? `닉네임을 설정해주세요` : `${name}`}
							</StyledP>
							<ButtonWrapper>
								<Button
									onClick={() => setIsOpenNameInput(true)}
									category="primary"
								>
									변경
								</Button>
							</ButtonWrapper>
						</>
					)}
				</FieldItem>
				<FieldItem>
					<StyledInputTitle activated={true}>주소</StyledInputTitle>
					<StyledP activated={address !== null}>
						{address === null ? `주소를 설정해주세요` : `${address}`}
					</StyledP>
					<ButtonWrapper>
						<Button onClick={() => setIsOpenKakao(true)} category="primary">
							변경
						</Button>
					</ButtonWrapper>
				</FieldItem>
				<FieldItem>
					<StyledInputTitle activated={true}>사이즈</StyledInputTitle>
					<StyledP activated={true}>{shoeSize}</StyledP>
					<ButtonWrapper>
						<Button onClick={() => setIsOpen(true)} category="primary">
							변경
						</Button>
					</ButtonWrapper>
				</FieldItem>
			</PersonalInfo>
			<Modal
				category="wish"
				onClose={() => setIsOpen(false)}
				show={isOpen}
				title="관심 상품 추가"
			>
				<ProductSizeSelectGrid
					activeSizeOption={newShoeSize}
					category="sizeOnly"
					onClick={(size) => {
						setNewShoeSize(size);
						// FIX ME - 회원 정보 수정 api
					}}
				/>
			</Modal>
			<Modal
				category="wish"
				onClose={() => setIsOpenKakao(false)}
				show={isOpenKakao}
			>
				<Post setIsOpenKakao={setIsOpenKakao} cb={putUserInfo}></Post>
			</Modal>
		</ProfileEditWrapper>
	);
};

export default ProfileEdit;

const ProfileEditWrapper = styled.div`
	padding-top: 38px;
	max-width: 480px;
`;

const LoginInfo = styled.div``;

const FieldItem = styled.div`
	margin: 0;
	padding: 25px 60px 18px 0;
	position: relative;
	border-bottom: 1px solid #ebebeb;
`;

const StyledP = styled.p<{ activated: boolean }>`
	padding-top: 6px;
	font-size: 16px;
	letter-spacing: -0.16px;
	margin: 0;
	padding: 0;
	color: ${({ activated }) => (activated ? `#222` : `rgba(34, 34, 34, 0.5)`)};
`;

const ButtonWrapper = styled.div`
	position: absolute;
	right: 0;
	bottom: 15px;
	padding-top: 1px;
	padding-left: 11px;
	padding-right: 12px;
`;

const NewInputWrapper = styled.div`
	position: relative;
	padding: 10px 0 14px;
	text-align: center;
`;

const ChangeButtonWrapper = styled.div`
	display: flex;
	justify-content: center;
`;

const PersonalInfo = styled.div`
	padding-top: 58px;
`;

const SubTitle = styled.h4`
	font-size: 18px;
	letter-spacing: -0.27px;
	margin: 0;
	padding: 0;
	// padding-bottom: 10px;
`;

const StyledInputTitle = styled.h3<{ activated: boolean }>`
	font-size: 13px;
	letter-spacing: -0.07px;
	line-height: 18px;
	color: ${({ activated }) => (activated ? `#222` : `rgba(34, 34, 34, 0.5)`)};
`;

const StyledInput = styled.input<{}>`
	width: 400px;
	outline: 0;
	border-width: 0 0 1px;
	height: 38px;
	line-height: 22px;
	font-size: 15px;
	border-color: #ebebeb;
	:focus {
		border-color: #222;
	}
	::placeholder {
		color: #d3d3d3;
	}
	:disabled {
		background-color: #fff;
	}
`;
