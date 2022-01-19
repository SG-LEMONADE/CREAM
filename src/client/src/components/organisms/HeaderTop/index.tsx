import React, {
	FunctionComponent,
	useCallback,
	useEffect,
	useState,
} from "react";
import Link from "next/link";
import { useRouter } from "next/router";

import { validateUser } from "utils/user";
import HeaderTopItem from "components/atoms/HeaderTopItem";

import colors from "colors/color";
import styled from "@emotion/styled";
import { customAxios } from "lib/customAxios";

const HeaderTop: FunctionComponent = () => {
	const router = useRouter();

	const [islogin, setIsLogin] = useState<boolean>(false);

	const onLogout = async () => {
		try {
			const res = await customAxios.post("/users/logout");
			if (res.data === "") {
				// user logout OK.
				console.log("userLogged out.");
				window.localStorage.removeItem("creamAcessToken");
				window.localStorage.removeItem("creamRefreshToken");
				alert("로그아웃 되셨습니다!");
				router.reload();
			}
		} catch (e) {
			console.log("sth wrong when logout.");
			console.log(e.response);
		}
		router.push("/");
	};

	const getCurrentUser = useCallback(async () => {
		try {
			const res = await validateUser();
			if (res) {
				console.log("will be changed!");
				setIsLogin(true);
			} else {
				console.log("검증 안됨");
				setIsLogin(false);
			}
			// will add userContext
		} catch (e) {
			console.log("api 요청에 문제..");
			console.log(e.response);
			setIsLogin(false);
		}
	}, []);

	useEffect(() => {
		console.log("get Current User...");
		getCurrentUser();
	}, [getCurrentUser]);

	return (
		<HeaderTopWrapper>
			<Link href={"https://hackmd.io/team/sglemonade?nav=overview"}>
				<a>
					<HeaderTopItem>우리들 이야기</HeaderTopItem>
				</a>
			</Link>
			{!islogin ? (
				<Link href={"/login"}>
					<a>
						<HeaderTopItem>관심상품</HeaderTopItem>
					</a>
				</Link>
			) : (
				<Link href={"/my/wish"}>
					<a>
						<HeaderTopItem>관심상품</HeaderTopItem>
					</a>
				</Link>
			)}
			{!islogin ? (
				<Link href={"/login"}>
					<a>
						<HeaderTopItem>관심상품</HeaderTopItem>
					</a>
				</Link>
			) : (
				<Link href={"/my"}>
					<a>
						<HeaderTopItem>마이페이지</HeaderTopItem>
					</a>
				</Link>
			)}
			{!islogin ? (
				<Link href={"/login"}>
					<a>
						<HeaderTopItem>로그인</HeaderTopItem>
					</a>
				</Link>
			) : (
				<HeaderTopItem style={{ marginLeft: "24px" }} onClick={onLogout}>
					로그아웃
				</HeaderTopItem>
			)}
		</HeaderTopWrapper>
	);
};

export default HeaderTop;

const HeaderTopWrapper = styled.header`
	display: flex;
	padding: 8px 40px;
	align-items: center;
	justify-content: flex-end;
	margin-left: auto;
	> a {
		margin-left: 24px;
	}
	border-bottom: 1px solid ${colors.colors.border};
`;
