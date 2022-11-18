import create from "zustand";

interface State {
  token: string | null;
  name: string | null;
  setToken: (token: string) => void;
  setName: (name: string) => void;
}

export const useStore = create<State>((set) => ({
  token: "",
  name: "",
  setToken: (token: string) => set({ token }),
  setName: (name: string) => set({ name }),
}));
