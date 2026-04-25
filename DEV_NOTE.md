# 私人 開發 筆記

## personal 分支

拿來自己使用，會有平常使用的腳本紀錄
拿新功能，是到這個`personal`分支`merge main`

### 強制追蹤 action.ahk & setting.ini

**原因:**  
為了確保所有其他分支的`.gitignore`都能保持一致  
就算`.gitignore`裡面有寫了不追蹤這兩個檔案，但還是使用"強制追蹤"的功能  
透過這個指令來繞過`.gitignore`繼續追蹤，才能在此分支有備份動作  
**做法:**  
`git add -f src/action.ahk src/setting.ini`

### 刪除 .template 模板

在這個分支裡面除了`ActionHub.exe`不被追蹤，其餘都可以直接操作/編輯

### 會有 setting.ini 頻繁 commit 的問題

**原因:**  
`setting.ini`會記錄視窗座標，導致每次變動都有`setting.ini commit`產生  
**做法:**  
平時只把`action.ahk` Staged，`setting.ini`放在旁邊就好  
真的要備份的時候再 Staged

<details>
  <summary>半自動的進階做法 (skip-worktree)</summary>  
  **缺點:**  
  如果要`commit setting.ini`要打指令解除狀態，有點麻煩

### 這些指令平時用不到，備而不用：

無視變動 (平時常駐):  
 `git update-index --skip-worktree src/setting.ini`  
 恢復追蹤變動 (新增熱鍵/改參數時):  
 `git update-index --no-skip-worktree src/setting.ini`

</details>
