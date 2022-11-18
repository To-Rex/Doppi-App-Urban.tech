import Apple from "../assets/Apple Logo.png";
import { makeStyles } from "@mui/styles";

const useStyles = makeStyles({
  apple: {
    display: "flex",
    flexDirection: "row",
    alignItems: "flex-start",
    padding: "15px",
    gap: "15px",
    maxWidth: "550px",
    width: "100%",
    height: "54px",
    background: "#000000",
    borderRadius: "10px",
  },
  text: {
    color: "#ffffff",
    fontSize: "20px",
    fontFamily: "SF Pro Display",
    fontWeight: "500",
    lineHeight: "24px",
  },
});

function AppleLogin() {
  const classes = useStyles();
  return (
    <button className={classes.apple}>
      <img
        src={Apple}
        alt="Apple"
        style={{
          width: "24px",
          height: "24px",
        }}
      />
      <p className={classes.text}>Sign in with Apple</p>
    </button>
  );
}

export default AppleLogin;
