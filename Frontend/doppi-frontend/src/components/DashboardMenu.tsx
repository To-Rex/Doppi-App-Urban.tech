import Drawer from "@mui/material/Drawer";
import ListItem from "@mui/material/ListItem";
import Box from "@mui/material/Box";
import ListItemButton from "@mui/material/ListItemButton";
import CreateIcon from "@mui/icons-material/Create";
import Fab from "@mui/material/Fab";
import AddIcon from "@mui/icons-material/Add";
import Dialog from "@mui/material/Dialog";
import DialogTitle from "@mui/material/DialogTitle";
import DialogContent from "@mui/material/DialogContent";
import DialogActions from "@mui/material/DialogActions";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import { useEffect, useState } from "react";
import toast, { Toaster } from "react-hot-toast";
import { useStore } from "../store/index";
import api from "../api";
import { Typography } from "@mui/material";

function DashboardMenu() {
  const [open, setOpen] = useState(false);
  const [itemOpen, setItemOpen] = useState(false);
  const [nameItem, setNameItem] = useState("");
  const [priceItem, setPriceItem] = useState("");

  const MyItem = ({ text, Icon }: any) => {
    return (
      <ListItem
        sx={{
          height: 50,
          width: "100%",
          padding: 0,
          marginBottom: 10,
        }}
      >
        <ListItemButton
          sx={{ color: "#949494" }}
          onClick={() => {
            setOpen(true);
          }}
        >
          <Icon
            sx={{
              marginRight: 2,
              color: "#949494",
            }}
          />
          {text}
        </ListItemButton>
      </ListItem>
    );
  };

  const { token } = useStore();

  const fetchAllItems = async () => {
    await api
      .get("api/product", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((res) => {
        console.log(res);
      });
  };

  const addProductCategory = async ({ text }: any) => {

    await api
      .post("api/product/add-category", {
        name: text,
        photo: "",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((res) => {
        console.log(res);
      })
      .catch((err) => {
        console.error(err);
      });
    setOpen(false);
  };

  useEffect(() => {
    fetchAllItems();
  }, []);

  const CategoryDialog = () => {
    const [nameMenu, setNameMenu] = useState("");

    return (
      <Dialog open={open}>
        <DialogContent>
          <Typography>Create a new category for your menu.</Typography>
          <TextField
            autoFocus
            margin="dense"
            id="name"
            label="Name"
            type="text"
            fullWidth
            variant="standard"
            onChange={(e) => setNameMenu(e.target.value)}
            value={nameMenu}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancel</Button>
          <Button onClick={() => addProductCategory(nameMenu)}>Save</Button>
        </DialogActions>
      </Dialog>
    );
  };

  return (
    <Box
      sx={{
        height: 250,
      }}
    >
      <Toaster />
      <CategoryDialog />
      <Drawer
        variant="permanent"
        anchor="left"
        sx={{
          "& .MuiDrawer-paper": {
            height: "calc(100% - 50px)",
            top: "51px",
            width: 200,
            padding: 0,
          },
        }}
      >
        <MyItem text="Create" Icon={CreateIcon} />
      </Drawer>
      <Fab
        color="primary"
        aria-label="add"
        sx={{
          position: "absolute",
          bottom: 100,
          right: 16,
        }}
        onClick={() => {
          //   handleDialog("Item");
        }}
      >
        <AddIcon />
      </Fab>
    </Box>
  );
}

export default DashboardMenu;
