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
				window.localStorage.removeItem("creamAccessToken");
				window.localStorage.removeItem("creamRefreshToken");
				alert("로그아웃 되셨습니다!");
				router.reload();
			}
		} catch (e) {
			console.error("STH wrong when user logout.");
			console.log(e.response);
		}
		router.push("/");
	};

	const getCurrentUser = useCallback(async () => {
		try {
			const res = await validateUser();
			if (res) {
				// Got current user well.
				setIsLogin(true);
			} else {
				setIsLogin(false);
			}
			// will add userContext
		} catch (e) {
			setIsLogin(false);
		}
	}, []);

	useEffect(() => {
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
